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
                cleanWs()
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
                    sh 'cp -v target/${APPLICATION_NAME}-${RELEASE_VERSION}-SNAPSHOT.zip ${APPLICATION_NAME}.zip'
                    sh '''
                        mvn org.mule.tools.maven:mule-maven-plugin:deploy \
                        -Dmule.home="${MULE_HOME}" \
                        -Dmule.application.name="${APPLICATION_NAME}" \
                        -Dmule.application="${APPLICATION_NAME}.zip" \
                    '''
                }
                 
            }
        }
        stage('Dockerization') { 
            steps {
                echo '### Build Mule-EE Docker Image ###'
                dir('scripts') {
                    git url: 'https://github.com/aimswebcraft001/cicd.git'
                    sh '''
                        cp -v /opt/mule/mule-ee-distribution-standalone-3.9.1.zip .
                        cp -v "${WORKSPACE}/project/helloworld.zip" .
                        docker build -t mule-ee:3.9.1 -f Dockerfile .
                    '''
                }
            }
        }
        stage('Run Container') { 
            steps {
                echo '### Run Mule-EE Contaier ###'
                dir('scripts') {
                    sh 'docker-compose up -d'
                }
            }
        }
    }
}