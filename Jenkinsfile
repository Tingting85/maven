pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Tingting85/maven.git'
            }
        }
        stage('Build') {
            steps {
                sh "mvn compile"
            }
        }
        stage('Test') {
            steps {
                sh "mvn test"
        }
            post {
                always {
                    junit '**/TEST*.xml'
                }
            }
        }
        stage ("Extract test results") {
            cobertura coberturaReportFile: 'path-to/coverage.xml'
        }
        stage('newman') {
            steps {
                 sh 'newman run Restful_Booker.postman_collection_labb.json --environment Restful_Booker.postman_environment_labb.json --reporters junit'
             }
            post {
                always {
                    junit '**/*xml'
                        }
                }
            }
        stage('robot') {
                    steps {
                        sh 'robot -d Results --variable BROWSER:headlesschrome Tests/Infotiv.robot'
                    }
                    post {
                        always {
                            script {
                                  step(
                                        [
                                          $class              : 'RobotPublisher',
                                          outputPath          : 'Results',
                                          outputFileName      : '**/output.xml',
                                          reportFileName      : '**/report.html',
                                          logFileName         : '**/log.html',
                                          disableArchiveOutput: false,
                                          passThreshold       : 50,
                                          unstableThreshold   : 40,
                                          otherFiles          : "**/*.png,**/*.jpg",
                                        ]
                                   )
                            }
                        }
                    }
                }
    }
    post {
         always {
            junit '**/TEST*.xml'
            emailext attachLog: true, attachmentsPattern: '**/TEST*xml',
            body: 'Bod-DAy!', recipientProviders: [culprits()], subject:
            '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!'
         }
    }
}