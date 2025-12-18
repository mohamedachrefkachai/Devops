pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "achrefkachai/spring-devops-app"
        DOCKER_TAG   = "latest"
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
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                        echo "Login to Docker Hub"
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build Maven + Docker + Push Docker Hub réussis"
        }
        failure {
            echo "❌ Échec du pipeline"
        }
    }
}
