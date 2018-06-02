pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                echo 'Build'
                git url: 'https://github.com/aimswebcraft001/ciMuleProject.git'
                sh 'mvn clean install -DskipTests=true' 
            }
        }
        stage('Unit Test') { 
            steps {
                echo 'Unit Test' 
            }
        }
        stage('Deploy') { 
            steps {
                echo 'Deploy' 
            }
        }
    }
}