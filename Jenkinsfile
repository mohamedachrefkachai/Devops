pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/mohamedachrefkachai/Devops.git'
            }
        }

        stage('Build') {
            steps {
                sh './mvnw clean package -DskipTests'
            }
        }
    }
}
