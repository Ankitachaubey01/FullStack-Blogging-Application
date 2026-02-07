pipeline {
    agent any
    
    tools {
        jdk 'jdk17'
        maven 'Maven'
    }
    
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'git-cred',
                    url: 'https://github.com/Ankitachaubey01/FullStack-Blogging-Application.git'
            }
        }

        stage('Compile') {
            steps {
                sh "mvn compile"
            }
        }

        stage('Test') {
            steps {
                sh "mvn test"
            }
        }

        stage('File System Scan') {
            steps {
                sh "trivy fs --format table -o trivy-fs-report.html ."
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh '''
                      $SCANNER_HOME/bin/sonar-scanner \
                      -Dsonar.projectName=bloggingapp \
                      -Dsonar.projectKey=bloggingapp \
                      -Dsonar.java.binaries=.
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-token'
                }
            }
        }

        stage('Build') {
            steps {
                sh "mvn package"
            }
        }

        stage('Publish To Nexus') {
            steps {
                withMaven(
                    globalMavenSettingsConfig: 'global-settings',
                    jdk: 'jdk17',
                    maven: 'maven3',
                    traceability: true
                ) {
                    sh "mvn deploy"
                }
            }
        }

        stage('Build & Tag Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh "docker build -t ankitachaubey99/bloggingapp:latest ."
                    }
                }
            }
        }

        stage('Docker Image Scan') {
            steps {
                sh "trivy image --format table -o trivy-image-report.html ankitachaubey99/bloggingapp:latest"
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh "docker push ankitachaubey99/bloggingapp:latest"
                    }
                }
            }
        }

        stage('Deploy To Kubernetes') {
            steps {
                withKubeConfig(
                    credentialsId: 'k8-cred',
                    namespace: 'webapps',
                    clusterName: 'prod-eks-cluster',
                    serverUrl: 'https://<EKS-ENDPOINT>'
                ) {
                    sh "kubectl apply -f deployment-service.yaml"
                }
            }
        }

        stage('Verify the Deployment') {
            steps {
                withKubeConfig(
                    credentialsId: 'k8-cred',
                    namespace: 'webapps',
                    clusterName: 'abrahimcse-cluster',
                    serverUrl: 'https://3BB24AA471B2EFD046041FA23A31BF19.yl4.us-west-2.eks.amazonaws.com'
                ) {
                    sh "kubectl get pods -n webapps"
                    sh "kubectl get svc -n webapps"
                }
            }
        }
    }   // ✅ THIS was missing earlier

    post {
        always {
            script {
                def jobName = env.JOB_NAME
                def buildNumber = env.BUILD_NUMBER
                def pipelineStatus = currentBuild.result ?: 'UNKNOWN'
                def bannerColor = pipelineStatus.toUpperCase() == 'SUCCESS' ? 'green' : 'red'

                def body = """
                <html>
                  <body>
                    <div style="border: 4px solid ${bannerColor}; padding: 10px;">
                      <h2>${jobName} - Build ${buildNumber}</h2>
                      <div style="background-color: ${bannerColor}; padding: 10px;">
                        <h3 style="color: white;">Pipeline Status: ${pipelineStatus.toUpperCase()}</h3>
                      </div>
                      <p>Check the <a href="${BUILD_URL}">console output</a>.</p>
                    </div>
                  </body>
                </html>
                """

                emailext(
                    subject: "${jobName} - Build ${buildNumber} - ${pipelineStatus.toUpperCase()}",
                    body: body,
                    to: 'ankitachaubey098@gmail.com',
                    mimeType: 'text/html',
                    attachmentsPattern: 'trivy-image-report.html'
                )
            }
        }
    }
}
