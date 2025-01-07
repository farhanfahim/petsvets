pipeline {
    agent any

    environment {
        PATH = '/Users/jenkins/.nvm/versions/node/v20.2.0/bin:/Users/jenkins/Public/flutter-3.19.1/bin:/Library/Frameworks/Python.framework/Versions/3.11/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Users/jenkins/Library/Android/sdk/platform-tools:/Users/jenkins/Library/Android/sdk/tools:/Users/jenkins/Library/Android/sdk/tools/bin:/Users/jenkins/Library/Android/sdk/emulator'
        appStoreUsername = "asim@tekrevol.com"
    }

    stages {

        stage("Last Commit Message") {
            steps {
                sh 'pwd'
                script {
                    commit = sh(returnStdout: true, script: 'git log -1 --oneline').trim()
                    commitMsg = commit.substring(commit.indexOf(' ')).trim()
                }
            }
        }

        stage('Switch to iOS directory') {
            steps {
                dir('ios') {
                    sh 'pwd'
                }
            }
        }

        stage('Setup Flutter') {
            steps {
                sh 'flutter --version'
            }
        }

        stage('Install dependencies') {
            steps {
                dir('ios') {
                    sh 'flutter clean'
                    sh 'flutter pub get'
                    sh 'pwd'
                    sh 'export LANG=en_US.UTF-8 && pod install'
                }
            }
        }

        stage('Build iOS ipa app') {
            steps {
                dir('ios') {
                    sh 'flutter build ipa'
                }
            }
        }

        stage('Validate to TestFlight') {
            steps {
                withCredentials([string(credentialsId: 'APPLE_UPLOAD_PASSWORD', variable: 'APP_STORE_PASSWORD')]) {
                    sh 'xcrun altool --validate-app --file /Users/jenkins/.jenkins/jobs/PetsVet-App/workspace/build/ios/ipa/petsvet_connect.ipa --type ios --username ${appStoreUsername} --password $APP_STORE_PASSWORD'
                }
            }
        }

        stage('Upload to TestFlight') {
            steps {
                withCredentials([string(credentialsId: 'APPLE_UPLOAD_PASSWORD', variable: 'APP_STORE_PASSWORD')]) {
                    sh 'xcrun altool --upload-app --file /Users/jenkins/.jenkins/jobs/PetsVet-App/workspace/build/ios/ipa/petsvet_connect.ipa --type ios --username ${appStoreUsername} --password $APP_STORE_PASSWORD'
                }
            }
        }
    }

    post {
        always {
            emailext(
                subject: "Pipeline ${currentBuild.currentResult}: ${commitMsg}",
                body: "${env.BUILD_URL}",
                attachLog: true,
                compressLog: true,
                replyTo: "devops@tekrevol.com",
            )
        }
        success {
            emailext(
                subject: "PetsVet-App iOS Pipeline Succeeded And Uploaded To Test Flight: ${commitMsg}",
                body: "PetsVet-App iOS For Jenkins Pipeline Succeeded",
                to: "khizar.javed@tekrevol.com,ahsan.nawaz@tekrevol.com",
                attachLog: true,
                compressLog: true,
                replyTo: "devops@tekrevol.com",
            )
            echo "Build succeeded!"
        }
        failure {
            emailext(
                subject: "Pipeline Failed PetsVet-App iOS Pipeline: ${commitMsg}",
                body: "PetsVet-App iOS Build For Jenkins Pipeline Failed",
                to: "khizar.javed@tekrevol.com,ahsan.nawaz@tekrevol.com",
                attachLog: true,
                compressLog: true,
                replyTo: "devops@tekrevol.com",
            )
            echo "Build failed!"
        }
    }
}
