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

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE_NAME)
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                withAWS(region: AWS_REGION, credentials: 'aws-credentials-id') {
                    sh """
                    $(aws ecr-public get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO)
                    docker tag $DOCKER_IMAGE_NAME:latest $ECR_REPO:$BUILD_NUMBER
                    docker push $ECR_REPO:$BUILD_NUMBER
                    """
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-credentials-id']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@3.6.160.242 << 'EOF'
                    docker pull $ECR_REPO:$BUILD_NUMBER
                    docker stop php-app || true
                    docker rm php-app || true
                    docker run -d --name php-app -p 80:80 $ECR_REPO:$BUILD_NUMBER
                    EOF
                    """
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
