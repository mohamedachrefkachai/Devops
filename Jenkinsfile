pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "tonusername/spring-devops-app"
        DOCKER_TAG   = "latest"
        DOCKER_CREDS = "dockerhub-creds"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/mohamedachrefkachai/Devops.git'
            }
        }

        stage('Prepare Build Environment') {
            steps {
                script {
                    if (fileExists('mvnw')) {
                        sh 'chmod +x mvnw'
                    } else if (fileExists('pom.xml')) {
                        echo 'Using system Maven installation'
                    } else {
                        error 'No pom.xml found. Not a Maven project?'
                    }
                }
            }
        }

        stage('Build (Maven)') {
            steps {
                script {
                    if (fileExists('mvnw')) {
                        sh './mvnw clean package -DskipTests'
                    } else {
                        sh 'mvn clean package -DskipTests'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh """
                    echo "Login to Docker Hub"
                    docker login -u \$DOCKER_USERNAME -p \$DOCKER_PASSWORD
                    docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build Maven + Docker + Push réussis"
        }
        failure {
            echo "❌ Échec du pipeline"
        }
    }
}
