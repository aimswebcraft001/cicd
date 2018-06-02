pipeline {
    agent any
    environment {
        APPLICATION_NAME='helloworld'
        RELEASE_VERSION='1.0'
        MULE_HOME='/opt/mule/mule-enterprise-standalone-3.9.1'
    } 
    stages {
        stage('Build') { 
            steps {
                echo '### Build ###'
                git url: 'https://github.com/aimswebcraft001/ciMuleProject.git'
                sh 'mvn clean install -DskipTests=true' 
            }
        }
        stage('Unit Test') { 
            steps {
                echo '### Unit Test ###'
                sh 'mvn integration-test' 
            }
        }
        stage('Deploy - Local') { 
            steps {
                echo '### Deploy ###'
                sh '''
                    mvn org.mule.tools.maven:mule-maven-plugin:deploy \
                    -Dmule.home="${MULE_HOME}" \
                    -Dmule.application.name="${APPLICATION_NAME}" \
                    -Dmule.application="${WORKSPACE}/target/${APPLICATION_NAME}-${RELEASE_VERSION}-SNAPSHOT.zip" \
                ''' 
            }
        }
    }
}