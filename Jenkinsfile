pipeline {
  agent any

  environment {
    PATH = "/usr/local/bin:${env.PATH}"
    VAULT_ADDR = credentials('vault_addr')
    VAULT_SKIP_VERIFY = "true"
    AWS_REGION = "us-west-2"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Authenticate to Vault') {
      steps {
        sh '''
        vault login -method=aws role=jenkins
        '''
      }
    }

    stage('Get AWS Credentials') {
      steps {
        sh '''
        CREDS=$(vault read -format=json aws/creds/eksvaultrole)

        export AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r .data.access_key)
        export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r .data.secret_key)
        export AWS_SESSION_TOKEN=$(echo $CREDS | jq -r .data.security_token)

        echo "AWS creds fetched from Vault"
        '''
      }
    }

    stage('Terraform Init') {
      steps {dir('terraform/prod'){
        sh 'terraform init'
      }}
    }

    stage('Terraform Plan') {
      steps {dir('terraform/prod'){
        sh 'terraform plan'
      }}
    }

    stage('Terraform Apply') {
      steps {dir('terraform/prod'){
        sh 'terraform apply -auto-approve'
      }}
    }
  }
}
