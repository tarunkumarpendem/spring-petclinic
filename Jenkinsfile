pipeline{
    agent{
        label 'node-1'
    }
    parameters{ 
        choice(name: 'branch', choices: ['main', 'REL_1.0', 'docker', 'test', 'spc'], description: 'branch of choice for image building') 
        }
    stages{
        stage('clone'){
            steps{
                git url: 'https://github.com/tarunkumarpendem/spring-petclinic.git',
                    branch: "${params.branch}"
            }
        }
        stage('image build and push'){
            environment{
                container_name = "spring-petclinic"
                default_image_name = "spc"
                default_image_tag = "1.0"
                REG = "a0zy1xp1qlv4e.jfrog.io/docker-docker"
            }
            steps{
                sh """
                      docker login -u tarunkumarpendem.1997@gmail.com a0zy1xp1qlv4e.jfrog.io -p AKCp8nyhkEYbqEQB1oYUXsd6AuQjmsCVD2nVji18maJyYbbJCp7eYpGAsg69D3aypenxN4skg
                      docker image build -t $env.default_image_name:$env.default_image_tag .
                      docker image tag $env.default_image_name:$env.default_image_tag ${REG}/${params.branch}:${BUILD_NUMBER} 
                      docker image push ${REG}/${params.branch}:${BUILD_NUMBER}
                      docker container run -d --name $env.container_name -P  ${REG}/${params.branch}:${BUILD_NUMBER}
                      docker ps
                      """
            }
        }
    }
}