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
                timeout(time:2, unit:'MINUTES') {
                    input message: 'Approve service deploy: '
                }
                sh '''
                whoami
                echo "Running services!!!"
                bash service-create.sh
                '''
            }
        }
    }
}
