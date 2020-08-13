pipeline {
  agent any
  environment {
    SVC_ACCOUNT_KEY = credentials('terraform-auth')
    VARIABLES = credentials('VARIABLES')
    PROVIDER = credentials('PROVIDER')
  }
  stages {
            stage('Checkout') {
                steps {
                    checkout scm
                    sh 'echo $SVC_ACCOUNT_KEY | base64 -d > serviceaccount.json'
                    sh 'echo $PROVIDER | base64 -d > provider.tf'
                    sh 'echo $VARIABLES | base64 -d > variable.tf'
                    }
             }
            stage('TF Plan') {
                steps {
                sh 'terraform init'
                sh 'terraform plan -out myplan'
            }
        }
        stage('Approval') {
                steps {
                    script {
                     def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
                }
            }
        }
        stage('TF Apply') {
                steps {
                    sh 'terraform apply myplan'
                    sh 'cp myplan ../k8s_destroy/'
                    sh 'cp terraform.tfstate* ../k8s_destroy/'
                    sh 'cp terraform.tfstate.backup ../k8s_destroy/'
                    sh 'sleep 60'
            }
        }
        stage('Docker storage') {
            steps {
                    sh 'ansible-playbook -i host.ini ansible/config.yml'
                    sh 'ansible-playbook -i host.ini ansible/docker-storage-setup-ofs.yml'
                    sh 'ansible-playbook -i host.ini ansible/masters.yml'
                    sh 'ansible-playbook -i host.ini ansible/worker.yml'
            }
        }
    }
}