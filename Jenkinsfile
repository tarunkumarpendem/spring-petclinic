pipeline {
    agent any
    environment {
        SSH_CREDENTIALS_ID = '42001297-5674-4158-a10f-a67b9f4b6a6b'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/tarunkumarpendem/spring-petclinic.git',
                    branch: 'ansible-jenkins'
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                sshagent([SSH_CREDENTIALS_ID]) {
                    sh '''
                    ansible-playbook -i hosts ansible-jenkins-playbook.yaml
                    '''
                }
            }
        }
    }
}
