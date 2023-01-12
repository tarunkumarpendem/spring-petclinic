pipeline{
    agent {
        label 'node-1'
    }
    /*parameters{
        choice(name: 'Branch_to_build', choices: ['main', 'REL_1.0'], description: 'selecting branch to build')
    }*/
    /*triggers{
        pollSCM('* * * * *')
    }*/
    stages{
        stage(clone){
            steps{
                git url: 'https://github.com/spring-projects/spring-petclinic.git',
                    branch: "REL_1.0"
            }
        }    
        stage(build){
          steps
            {
                withSonarQubeEnv('sonarqube') {
                     sh "mvn clean install sonar:sonar"
               }
            }
        }
        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }
        stage ('Artifactory configuration') {
            steps {
                rtMavenDeployer (
                    id: "jfrog-deployer-id",
                    serverId: "jfrog-server-id",
                    releaseRepo: 'test-libs-release-local',
                    snapshotRepo: 'test-libs-snpshot-local'
                )
            }
        }
        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: "maven", // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "jfrog-deployer-id"
                )
            }
        }
        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "jfrog-server-id"
                )
            }
        }
    }
    post{
        always{
            echo 'build completed'
            mail to: 'tarunkumarpendem22@gmail.com',
                 subject: 'Job summary',
                 body: """Build is completed for $env.BUILD_URL"""
        }
        failure{
            echo 'build failed'
            mail to: 'tarunkumarpendem22@gmail.com',
                 subject: 'Job summary',
                 body: """Build is failed for $env.BUILD_NUMBER
                          $env.BUILD_URL
                          $env.BUILD_ID"""
        }
        success{
            junit '**/surefire-reports/*.xml'
            echo 'build is success'
            mail to: 'tarunkumarpendem22@gmail.com',
                 subject: 'Job summary',
                 body: """Build is successfully completed for $env.BUILD_NUMBER
                          $env.BUILD_URL"""
        }
    }
}
