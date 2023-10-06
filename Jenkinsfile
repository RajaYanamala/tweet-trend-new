pipeline{
    agent{
        node{
            label 'jenkins-slave'
        }
    }
    stages{
        stage('Build'){
            steps{
                sh 'mvn clean deploy'
            }
        }
    }
}
