pipeline {
     agent{
        label 'node-1'
    }
    parameters{
        //choice(name: 'Branch_to_build', choices: ['main', 'REL_1.0', 'docker', 'test'], description: 'selecting branch to build')
        choice(name: 'Image_type', choices: ['base_image', 'infra_image', 'test_image', 'none','image'], description: 'Selecting image build type')
    }
    stages {
        stage('image build') {
            steps {
                script{
                    def REG = "jan2k23.jfrog.io/docker-docker"
                    def IMAGE_NAME_1 = "nginx"
                    def IMAGE_NAME_2 = "alpine"
                    def IMAGE_NAME_3 = "httpd"
                    if (params ['Image_type'] == "base_image" ){
                        sh """
                        docker image pull ${IMAGE_NAME_1}
                        docker image tag ${IMAGE_NAME_1} ${REG}/${IMAGE_NAME_1}:${params.Image_type}-${BUILD_NUMBER}
                        echo image tagging done for base image
                        """
                    } 
                    else if (params ['Image_type'] == "infra_image"){
                        sh """
                            docker image pull ${IMAGE_NAME_2}
                            docker image tag ${IMAGE_NAME_2} ${REG}/${IMAGE_NAME_2}:${params.Image_type}-${BUILD_NUMBER}
                            echo image tagging done for infra image
                            """
                    } 
                    else if (params ['Image_type'] == "test_image"){
                        sh """
                             docker image pull ${IMAGE_NAME_3}
                             docker image tag ${IMAGE_NAME_3} ${REG}/${IMAGE_NAME_3}:${params.Image_type}-${BUILD_NUMBER}
                             echo image tagging done for test image
                             """

                    }
                    else if (params ['Image_type'] == "none"){
                        sh "echo Image type is none"
                    }
                    else {
                        sh "echo image tagging failed"
                    }         
                }
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










pipeline{
    agent{
        label 'node-1'
    }
    parameters{
        //choice(name: 'Branch_to_build', choices: ['main', 'REL_1.0', 'docker', 'test'], description: 'selecting branch to build')
        choice(name: 'Image_type', choices: ['base_image', 'infra_image', 'test_image', 'none','image'], description: 'Selecting image build type')
    }
    /*triggers{
        pollSCM('* * * * *')
    }*/
    stages{
        // stage('pull'){
        //     steps{
        //         sh """
        //               docker image pull ubuntu:20.04
        //               docker image tag ubuntu:20.04 jan2k23.jfrog.io/docker-docker/ubuntu:20.04-jfrog
        //               docker push jan2k23.jfrog.io/docker-docker/ubuntu:20.04-jfrog
        //             """  
        //     }
        //}
        stage('image tagging'){
            environment{
                REG = "jan2k23.jfrog.io/docker-docker"
                IMAGE_NAME_1 = "nginx"
                IMAGE_NAME_2 = "alpine"
                IMAGE_NAME_3 = "httpd"
            }
            steps{
                script{ 
                    if (params ['Image_type'] == "base_image" ){
                        sh """
                            docker image pull ${env.IMAGE_NAME_1}
                            docker image tag ${env.IMAGE_NAME_1} ${env.REG}/${env.IMAGE_NAME_1}:${params.Image_type}-${BUILD_NUMBER}
                            echo image tagging done for base image
                            docker image ls
                            """
                    } 
                    else if (params ['Image_type'] == "infra_image"){
                        sh """
                            docker image pull ${env.IMAGE_NAME_2}
                            docker image tag ${env.IMAGE_NAME_2} ${env.REG}/${env.IMAGE_NAME_2}:${params.Image_type}-${BUILD_NUMBER}
                            echo image tagging done for infra image
                            docker image ls
                            """
                    } 
                    else if (params ['Image_type'] == "test_image"){
                        sh """
                            docker image pull ${env.IMAGE_NAME_3}
                            docker image tag ${env.IMAGE_NAME_3} ${env.REG}/${env.IMAGE_NAME_3}:${params.Image_type}-${BUILD_NUMBER}
                            echo image tagging done for test image
                            docker image ls
                            """
                    }
                    else if (params ['Image_type'] == "none"){
                         sh "echo Image_type is none"
                    }
                    else {
                        sh "echo image tagging failed"
                    }         
                }
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
            echo 'build is success'
            mail to: 'tarunkumarpendem22@gmail.com',
                 subject: 'Job summary',
                 body: """Build is successfully completed for $env.BUILD_NUMBER
                          $env.BUILD_URL"""
        }
    }       
}











// stages{
    //     stage('image build and push to jfrog'){
    //         steps{
    //             script{
    //                 def RES = "jan2k23.jfrog.io/docker-docker/"
    //                 def appname = "spring-petclinic"
    //                     if (gitBranch.contains('docker')) {
    //                        'docker image build -t ${RES}-${appname}:${BUILD_NUMBER} .'
    //                     }
    //                     else if (gitBranch.contains('test')) {
    //                        env.extractbranch = gitBranch.sampleprinter("/")[0].toLowerCase()
    //                        env.extractbranch1 = gitBranch.sampleprinter("/")[1].toLowerCase()
    //                        'docker image build -t ${RES}-${appname}:${extractbranch}-${extractbranch1}-${BUILD_NUMBER}'
    //                     }
    //                     else {
    //                         echo "image build failed"
    //                  }
    //             }
    //         }
    //     }
    // }
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