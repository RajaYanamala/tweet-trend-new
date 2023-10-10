pipeline{
    agent{
        node{
            label 'maven'
        }
    }
    stages{
        stage('Build'){
            steps{
                sh 'mvn clean deploy'
            }
        }
        stage('SonarQube analysis') {
            environment{
                scannerHome = tool 'TeamProject-SonarQube-Scanner';
            }
            steps{
                withSonarQubeEnv('TeamProject-SonarQube-Server') { 
                 sh "${scannerHome}/bin/sonar-scanner"}
            }
        }
    }
}
