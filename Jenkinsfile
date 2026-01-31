pipeline {
  agent any

  parameters {
    choice(
      name: 'environment',
      choices: ['dev', 'qa', 'prod'],
      description: 'Select environment'
    )
  }

  stages {

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh "terraform plan -var-file=envs/${ENV}/terraform.tfvars"
      }
    }

    stage('Approval') {
      steps {
        input message: "Do you want to APPLY Terraform changes to ${ENV}?",
              ok: 'Apply Now'
      }
    }

    stage('Terraform Apply') {
      steps {
        sh "terraform apply -auto-approve -var-file=envs/${ENV}/terraform.tfvars"
      }
    }
  }
}
