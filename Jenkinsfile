pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                echo 'Build'
                git url: 'https://github.com/aimswebcraft001/cicd.git' 
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