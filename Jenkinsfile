pipeline {
    agent any
    environment {
        APPLICATION_NAME='helloworld'
        RELEASE_VERSION='1.0'
        MULE_HOME='/opt/mule/mule-enterprise-standalone-3.9.1'
    } 
    stages {
        stage('Build - App') { 
            steps {
                echo '### Build ###'
                dir('project') {
                    git url: 'https://github.com/aimswebcraft001/ciMuleProject.git'
                    sh 'mvn clean install -DskipTests=true' 
                }
            }
        }
        stage('Unit Test') { 
            steps {
                echo '### Unit Test ###'
                dir('project') {
                    sh 'mvn test' 
                }
            }
        }
        stage('Deploy') { 
            steps {
                echo '### Deploy ###'
                dir('project') {
                    sh '''
                        mvn org.mule.tools.maven:mule-maven-plugin:deploy \
                        -Dmule.home="${MULE_HOME}" \
                        -Dmule.application.name="${APPLICATION_NAME}" \
                        -Dmule.application="${WORKSPACE}/target/${APPLICATION_NAME}-${RELEASE_VERSION}-SNAPSHOT.zip" \
                    '''
                }
                 
            }
        }
        stage('Build - Docker Image') { 
            steps {
                echo '### Build Mule-EE Docker Image ###'
                dir('scripts') {
                    git url: 'https://github.com/aimswebcraft001/cicd.git'
                    sh '''
                        cp -v /opt/mule/mule-ee-distribution-standalone-3.9.1.zip .
                        cp -v "${WORKSPACE}/projecct/target/helloworld.zip" .
                        ls -ltrh
                        docker build -t mule-ee:3.9.1 -f Dockerfile .
                    '''
                }
            }
        }
    }
}