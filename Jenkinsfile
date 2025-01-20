pipeline {
    agent any

    environment {
        SERVER_IP = credentials('prod-server-ip')
    }
    stages {
        stage('Setup') {
            steps {
                sh '''
		python3 -m venv venv
		. venv/bin/activate
		pip install -r requirements.txt
		'''
	    }
        }
        stage('Test') {
            steps {
                sh '''
		. venv/bin/activate
		pytest
		'''
            }
        }

        stage('Package code') {
            steps {
                sh "zip -r myapp.zip ./* -x '*.git*' -x 'venv/*'"
                sh "ls -lart"
            }
        }

        stage('Deploy to Prod') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ssh-key', keyFileVariable: 'MY_SSH_KEY', usernameVariable: 'username')]) {
                    sh '''
                    scp -i $MY_SSH_KEY -o StrictHostKeyChecking=no myapp.zip ${username}@${SERVER_IP}:/home/ubuntu/
                    ssh -i $MY_SSH_KEY -o StrictHostKeyChecking=no ${username}@${SERVER_IP} << EOF
			 unzip -o /home/ubuntu/myapp.zip -d /home/ubuntu/to-do-app/
			 bash /home/ubuntu/to-do-app/deploy_app.sh
EOF
                    '''
                }
            }
        }
       
        
       
        
    }
}
