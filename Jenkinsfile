pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mohamedachrefkachai/Devops.git'
            }
        }

        stage('Prepare Build Environment') {
            steps {
                script {
                    // Check if mvnw exists and make it executable
                    if (fileExists('mvnw')) {
                        sh 'chmod +x mvnw'
                    } else if (fileExists('pom.xml')) {
                        // Use system Maven if mvnw doesn't exist
                        echo 'Using system Maven installation'
                    } else {
                        error 'No pom.xml found. Not a Maven project?'
                    }
                }
            }
        }

        stage('Build') {
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
    }
}
