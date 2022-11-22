pipeline{
    agent {
        label 'python3.10'
    }
    parameters{
        choice(name: 'Branch_to_build', choices: ['main', 'REL_1.0'], description: 'selecting branch to build')
    }
    post{
        always{
            echo 'build completed for $env.BUILD_NUMBER'
            mail to: 'tarunkumarpendem22@gmail.com',
                 subject: 'Job summary',
                 body: "Build is completed for $env.BUILD_URL"
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
                    branch: "${params.Branch_to_build}"
            }
        }    
        stage(build){
            steps{
                sh 'mvn clean install'
            }
        }
        stage('Archive_artifacts'){
            steps{
                archiveArtifacts artifacts: '**/target/*.jar', followSymlinks: false
            }
        }
        stage('Junit'){
            steps{
                junit '**/surefire-reports/*.xml'
            }
        }
    }
}
