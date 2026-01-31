pipeline {
  agent any

  parameters {
    choice(name: 'ENV', choices: ['dev', 'qa', 'prod'])
  }

  stages {

    stage('Checkout') {
      steps {
        git 'https://github.com/<org>/terraform-eks.git'
      }
    }

    stage('Fetch AWS creds from Vault') {
      steps {
        withVault(
          vaultSecrets: [[
            path: 'aws/creds/eks-role',
            secretValues: [
              [envVar: 'AWS_ACCESS_KEY_ID', vaultKey: 'access_key'],
              [envVar: 'AWS_SECRET_ACCESS_KEY', vaultKey: 'secret_key'],
              [envVar: 'AWS_SESSION_TOKEN', vaultKey: 'security_token']
            ]
          ]]
        ) {
          sh 'aws sts get-caller-identity'
        }
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -var-file=envs/${ENV}/terraform.tfvars'
      }
    }

    stage('Approval') {
      when { expression { params.ENV == 'prod' } }
      steps {
        input message: "Approve Terraform Apply for ${ENV}?"
      }
    }

    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve -var-file=envs/${ENV}/terraform.tfvars'
      }
    }
  }
}
