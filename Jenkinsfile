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
                echo "Running services!!!"
                bash service_create.sh
                '''
            }
        }
    }
}
