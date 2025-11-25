pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/anikettalwekar/terraform-aws-project.git'
            }
        }

        stage('Setup Terraform') {
            steps {
                sh '''
                terraform --version
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh '''
                    terraform init
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh '''
                    terraform plan -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh '''
                    terraform apply -auto-approve tfplan
                    '''
                }
            }
        }
    }
}
