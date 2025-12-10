pipeline {
    agent any

    stages {
        stage("Checkout") {
            steps {
                // Le repo est public, pas besoin de credentials
                git branch: "main",
                    url: "https://github.com/mohamedachrefkachai/Devops.git"
            }
        }

        stage("Build") {
            steps {
                sh "mvn clean package -DskipTests"
            }
        }

        stage("Build Docker Image") {
            steps {
                sh "docker build -t yasswdy/student-management:latest ."
            }
        }

        stage("Push Docker Image") {
            steps {
                // Utilise tes credentials Docker Hub
                withCredentials([usernamePassword(credentialsId: 'DOCKERHUB_CREDENTIALS', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push yasswdy/student-management:latest'
                }
            }
        }
    }

    post {
        success {
            echo "Build et push Docker rÃ©ussis ! "
        }
        failure {
            echo "Build Ã©chouÃ© "
        }
    }
}