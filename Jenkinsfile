// pipeline{
//     agent {
//         label 'node-1'
//     }
//     parameters{
//         choice(name: 'Branch_to_build', choices: ['main', 'REL_1.0'], description: 'selecting branch to build')
//     }
//     /*triggers{
//         pollSCM('* * * * *')
//     }*/
//     post{
//         always{
//             echo 'build completed'
//             mail to: 'tarunkumarpendem22@gmail.com',
//                  subject: 'Job summary',
//                  body: """Build is completed for $env.BUILD_URL"""
//         }
//         failure{
//             echo 'build failed'
//             mail to: 'tarunkumarpendem22@gmail.com',
//                  subject: 'Job summary',
//                  body: """Build is failed for $env.BUILD_NUMBER
//                           $env.BUILD_URL
//                           $env.BUILD_ID"""
//         }
//         success{
//             junit '**/surefire-reports/*.xml'
//             echo 'build is success'
//             mail to: 'tarunkumarpendem22@gmail.com',
//                  subject: 'Job summary',
//                  body: """Build is successfully completed for $env.BUILD_NUMBER
//                           $env.BUILD_URL"""
//         }
//     }
//     stages{
//         stage(clone){
//             steps{
//                 git url: 'https://github.com/tarunkumarpendem/spring-petclinic.git',
//                     branch: "${params.Branch_to_build}"
//             }
//         }    
//         stage(build){
//           steps
//             {
//                 withSonarQubeEnv('sonarqube') {
//                      sh "mvn package sonar:sonar"
//                }
//             }
//         }
//         /*stage('Quality Gate') {
//             steps {
//               timeout(time: 30, unit: 'MINUTES') {
//                 waitForQualityGate abortPipeline: true
//               }
//             }
//         }*/
//         stage ('Artifactory configuration') {
//             steps {
//                 rtMavenDeployer (
//                     id: "jfrog-id-deployer-id",
//                     serverId: "jfrog-server-id",
//                     releaseRepo: 'maven',
//                     snapshotRepo: 'maven'
//                 )
//             }
//         }
//         stage ('Exec Maven') {
//             steps {
//                 rtMavenRun (
//                     tool: "maven", // Tool name from Jenkins configuration
//                     pom: 'pom.xml',
//                     goals: 'clean install',
//                     deployerId: "jfrog-id-deployer-id"
//                 )
//             }
//         }
//         stage ('Publish build info') {
//             steps {
//                 rtPublishBuildInfo (
//                     serverId: "jfrog-server-id"
//                 )
//             }
//         }
//     }
// }




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
                    sh 'mvn package sonar:sonar -Dsonar.organization=spc -Dsonar.projectKey=spc_spring-petclinic'
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