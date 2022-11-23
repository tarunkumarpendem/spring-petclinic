pipeline{
    agent {
        label 'python3.10'
    }
    /*parameters{
        choice(name: 'Branch_to_build', choices: ['main', 'REL_1.0'], description: 'selecting branch to build')
    }*/
    /*triggers{
        pollSCM('* * * * *')
    }*/
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
            echo 'build is success'
            mail to: 'tarunkumarpendem22@gmail.com',
                 subject: 'Job summary',
                 body: """Build is successfully completed for $env.BUILD_NUMBER
                          $env.BUILD_URL"""
        }
    }
    stages{
        stage(clone){
            steps{
                git url: 'https://github.com/spring-projects/spring-petclinic.git',
                    branch: "main"
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
        stage ('Artifactory configuration') {
            steps {
                rtMavenDeployer (
                    id: "jfrog",
                    serverId: "jfrog",
                    releaseRepo: 'libs-release-local',
                    snapshotRepo: 'libs-snpshot-local'
                )
            }
        }
        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: "MVN-3.6.3", // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "jfrog"
                )
            }
        }
        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "jfrog"
                )
            }
        }
    }
}
