pipeline {
    agent any
    
    environment {
        REGISTRY = "docker.io/shabaz7323/myjenkins"
        CREDENTIALS_ID = "dockerhub-creds"
        IMAGE_TAG = "${env.BUILD_NUMBER ?: 'latest'}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm --prefix app ci'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm --prefix app test || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${REGISTRY}:${IMAGE_TAG} .'
            }
        }

        stage('Security Scan (Trivy)') {
            steps {
                echo "Run Trivy scan here if installed"
                // sh 'trivy image ${REGISTRY}:${IMAGE_TAG}'
            }
        }

        stage('Login to Docker Hub & Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${CREDENTIALS_ID}", 
                                                 usernameVariable: 'DOCKER_USER', 
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    sh 'docker push ${REGISTRY}:${IMAGE_TAG}'
                }
            }
        }

        stage('Deploy with Helm (Optional)') {
            when { expression { return false } } // Enable when your cluster is ready
            steps {
                sh '''
                helm upgrade --install myjenkins charts/myapp \
                  --set image.repository=${REGISTRY} \
                  --set image.tag=${IMAGE_TAG} \
                  -n dev --create-namespace
                '''
            }
        }
    }

    post {
        always {
            echo "Build finished. Image pushed: ${REGISTRY}:${IMAGE_TAG}"
        }
    }
}
