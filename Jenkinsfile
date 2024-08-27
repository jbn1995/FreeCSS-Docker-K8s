pipeline {
    agent any
    
    stages{
        stage('Pull code from github'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/jbn1995/automation_p_jenkins_docker_k8s.git']]])
            
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t jabin95/nginx-custom-container:02 .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([usernamePassword(credentialsId: 'dockerID', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'docker login -u $USERNAME -p $PASSWORD'
                    }
                    sh 'docker push jabin95/nginx-custom-container:02'
                }
            }
        }
        stage('Deploy to k8s') {
            steps {
                script {
                    // Point kubectl to Minikube's context
                    sh 'kubectl config use-context minikube'

                    // Deploy the Kubernetes configurations
                    sh 'kubectl apply -f deployment_service.yml'
                    sh 'kubectl get services'
                    sh 'minikube service service-webapp'
                }
            }
        }
    }
}
