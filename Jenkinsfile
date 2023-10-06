pipeline{
    agent{
        node{
            label 'jenkins-slave'
        }
    }
    stages{
        stage(GIT Clone){
            steps{
                git branch: 'main', url: 'https://github.com/RajaYanamala/tweet-trend-new.git'
            }
        }
    }
}
