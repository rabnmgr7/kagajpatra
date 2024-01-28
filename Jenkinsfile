pipeline {
    agent {
    	label 'ubuntu-slave-worker1'
    }
    stages {
        stage('BuildImages') {
            steps {
                sh '''
                echo "Building Docker Images"
                bash ./bin/image-build.sh
                '''
            }
        }
        stage('TestRun') {
            agent {
                label 'ubuntu-slave-worker1'
            }
            steps {
                timeout(time:2, unit:'MINUTES') {
                    input message: 'Approve for TestRun: '
                }
                sh '''
                echo "Determining user"
                whoami
                echo "Running services!!!"
                bash ./bin/service-create.sh
                '''
            }
        }
	      stage('RegistryPush') {
	          agent {
	              label 'ubuntu-slave-worker1'
	          }
		steps {
                    timeout(time:5, unit:'MINUTES') {
                        input message: 'Approve to push image to Harbor Registry: '
                    }
	            sh '''
	                echo "Pushing images:latest to harbor registry.."
	                bash ./bin/registry-push.sh
	            '''
	          }
	      }
	      stage('DeployKagajpatra') {
	          agent {
	              label 'ubuntu-slave-manager1'
	          }
	          steps {
		      timeout(time:5, unit:'MINUTES') {
                          input message: 'Approve to Deploy app to ubuntu-slave-manager1 node: '
		      }
	              sh '''
	              echo "Deploying images:latest to ubuntu-slave-manager1 node.."
	              bash ./bin/deploy.sh
                      '''
	          }
	      }
    }
    post {
        always {
            mail to: 'rabnmgr7@outlook.com, rabinonlineservice@gmail.com, rabnmgr7@gmail.com, pungita777@gmail.com',
                subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) Completed running",
                body: "Please go to ${BUILD_URL} and verify the build."
        }
	success {
            mail to: 'rabnmgr7@outlook.com, rabinonlineservice@gmail.com, rabnmgr7@gmail.com, pungita777@gmail.com',
                subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) Success",
                body: "Kagajpatra Build No.: (${BUILD_NUMBER}) is a successful build. Please go to ${BUILD_URL} to review it."
        }
    } 
}
