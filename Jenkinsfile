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
        stage('Deploy in QA Instance') {
            agent {
                label 'built-in-node'
            }
            steps {
                sh '''
                echo "Creating Containers for QA Instance"
                bash service_create.sh
                '''
            }
        }
        stage('Deploy in Stagging Instance') {
            agent {
                label 'built-in-node'
            }
            steps {
                timeout(time:1, unit:'MINUTES') {
                    input message: 'Approve the stagging deployemnt.'
                }
                sh '''
                echo "We are deploying the app in stagging env."
                cp ./container-create.sh ./stagging-container-create.sh
                sed -i 's/kagajpatra_web/stagging_kagajpatra_web/g' stagging-container-create.sh
                sed -i 's/kagajpatra_nginx/stagging_kagajpatra_nginx/g' stagging-container-create.sh
                sed -i 's/kagajpatra_mysql/stagging_kagajpatra_mysql/g' stagging-container-create.sh
            
                sed -i 's/5000:5000/5001:5000/g' stagging-container-create.sh
                sed -i 's/3306:3306/3307:3307/g' stagging-container-create.sh
                sed -i 's/8200:80/8201:80/g' stagging-container-create.sh
                bash stagging-container-create.sh
                '''
            }
        }
    }
}
