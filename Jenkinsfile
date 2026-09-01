pipeline {
    agent any

    environment {
        FLOCI_ENDPOINT = "http://floci:4566"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Load tfvars') {
            steps {
                withCredentials([file(credentialsId: 'floci-terraform-tfvars', variable: 'TFVARS_FILE')]) {
                    sh 'rm -f terraform.tfvars && cp "$TFVARS_FILE" terraform.tfvars && chmod 644 terraform.tfvars'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                    terraform init \
                      -backend-config="endpoints={s3=\\"${FLOCI_ENDPOINT}\\"}" \
                      -reconfigure
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -var="floci_endpoint=${FLOCI_ENDPOINT}"'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve -var="floci_endpoint=${FLOCI_ENDPOINT}"'
            }
        }

        stage('Show DB Endpoint') {
            steps {
                sh 'terraform output db_host'
                sh 'terraform output db_port'
            }
        }
    }
}
