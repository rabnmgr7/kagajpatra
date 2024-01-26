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
                    input message: 'Approve service deploy: '
                }
                sh '''
                echo "Running services!!!"
                bash service-create.sh
                '''
            }
        }
    }
}
