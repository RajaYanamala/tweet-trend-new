pipeline{
    agent{
        node{
            label 'maven'
        }
    }
    stages{
        stage('Build'){
            steps{
                echo '------------Build Started --------------------'
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                echo '------------ Build Completed ------------------'
            }
        }
        
        stage('Test'){
            steps{
                echo '------------Test Started --------------------'
                sh 'mvn surefire-report:report'
                echo '------------Test Completed --------------------'
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
