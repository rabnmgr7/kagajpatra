pipeline {
    agent {
    	label 'built-in-node'
    }
    stages {
        stage('BuildImages') {
            steps {
                sh '''
                echo "Building Docker Images"
                bash image-build.sh
                '''
            }
        }
        stage('DeployServices') {
            agent {
                label 'ubuntu-slave-worker1'
            }
            steps {
                timeout(time:1, unit:'MINUTES') {
                    input message: 'Approve the stagging deployemnt.'
                }
                script {
                    // Extract credentials dynamically
                    def harborRegistryCred = credentials("${HARBOR_REGISTRY_CRED_ID}")
                    withEnv(['HARBOR_REGISTRY_USER=' + harborRegistryCred.username, 'HARBOR_REGISTRY_PASSWORD=' + harborRegistryCred.password]) {
                        sh '''
                        echo "Running services!!!"
                        bash service-create.sh
                        '''
                    }
                }
            }
        }
    }
}
