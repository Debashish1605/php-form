pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'php-app'
        ECR_REPO = 'public.ecr.aws/h4q9z7i2/php-app'
        AWS_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/Debashish1605/php-form.git'
            }
        }

        stage('Print Environment Variables') {
            steps {
                script {
                    echo "Docker Image Name: ${DOCKER_IMAGE_NAME}"
                    echo "ECR Repo: ${ECR_REPO}"
                    echo "AWS Region: ${AWS_REGION}"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
