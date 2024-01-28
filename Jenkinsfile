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
                echo "Determining user"
                whoami
                echo "Running services!!!"
                bash service-create.sh
                '''
            }
        }
    }
    post {
        always {
            mail to: 'rabnmgr7@outlook.com, rabinonlineservice@gmail.com, rabnmgr7@gmail.com, pungita777@gmail.com',
                subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) Completed running",
                body: "Please go to ${BUILD_URL} and verify the build"
        }
    } 
}
