def registry = 'https://rajayanamala.jfrog.io/'
def imageName = 'rajayanamala.jfrog.io/teamproject-docker-local/teamproject'
def version   = '2.1.2'
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
        stage("Quality Gate"){
            steps{
                script{
                    timeout(time: 1, unit: 'HOURS') { 
                    def qg = waitForQualityGate() 
                    if (qg.status != 'OK') {
                    error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
               }
            }   
       }
        stage("Jar Publish") {
            steps {
                script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"Jfrog-Credentials"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
                }
            }   
        } 
        stage(" Docker Build ") {
            steps {
                script {
                    echo '<--------------- Docker Build Started --------------->'
                    app = docker.build(imageName+":"+version)
                    echo '<--------------- Docker Build Ends --------------->'
                }
            }
        }

        stage (" Docker Publish "){
            steps {
                script {
                    echo '<--------------- Docker Publish Started --------------->'  
                    docker.withRegistry(registry, 'Jfrog-Credentials'){
                    app.push()
                    echo '<--------------- Docker Publish Ended --------------->'  
                    }    
                }
            }
        }  
    }
}
