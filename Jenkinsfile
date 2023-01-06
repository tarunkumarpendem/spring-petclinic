pipeline{
    agent{
        label 'node-1'
    }
    /*parameters{
        choice(name: 'Branch_to_build', choices: ['main', 'REL_1.0'], description: 'selecting branch to build')
    }*/
    /*triggers{
        pollSCM('* * * * *')
    }*/
    stages{
        stage('image build and push to jfrog'){
            steps{
                script{
                    def RES = "jan2k23.jfrog.io/docker-docker/"
                    def appname = "spring-petclinic"
                        if (gitBranch.contains('docker')) {
                           'docker image build -t ${RES}-${appname}:${BUILD_NUMBER} .'
                        }
                        else if (gitBranch.contains('test')) {
                           env.extractbranch = gitBranch.sampleprinter("/")[0].toLowerCase()
                           env.extractbranch1 = gitBranch.sampleprinter("/")[1].toLowerCase()
                           'docker image build -t ${RES}-${appname}:${extractbranch}-${extractbranch1}-${BUILD_NUMBER}'
                        }
                        else {
                            echo "image build failed"
                     }
                }
            }
        }
    }
       /*post{
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
    }*/     
}
