pipeline{
    agent{
        label 'spc'
    }
    triggers{
        pollSCM('* * * * *')
    }
    stages{
        stage('clone'){
            steps{
                git url: 'https://github.com/tarunkumarpendem/spring-petclinic.git',
                    branch: 'develop'
            }
        }
        stage('build and package'){
            steps{
                withSonarQubeEnv('sonar_cloud'){
                    sh './mvnw package sonar:sonar -Dsonar.organization=spc -Dsonar.projectKey=spc_spring-petclinic -Dsonar.projectName=spring-petclinic'
                }
            }
        }
        stage ('Artifactory configuration') {
            steps {
                rtMavenDeployer (
                    id: "jfrog-deployer-id",
                    serverId: "jfrog-server-id",
                    releaseRepo: 'maven-libs-release-local',
                    snapshotRepo: 'maven-libs-snapshot-local'
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
                 body: """Build is completed for $env.BUILD_URL
                          $env.BUILD_ID"""
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