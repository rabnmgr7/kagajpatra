pipeline {
    agent {
    	label 'built-in-node'
    }
    environment {
        HARBOR_REGISTRY_USER = 'credentials('harbor-registry-cred').username'
        HARBOR_REGISTRY_PASSWORD = 'credentials('harbor-registry-cred').password'
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
                    withEnv(['HARBOR_REGISTRY_USER', 'HARBOR_REGISTRY_PASSWORD']) {
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
