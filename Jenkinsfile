pipeline {
  agent any
  environment {
    REGISTRY = "vinaykumars064/cicd-repo"            // <<-- Replace with your Docker repo (user/repo)
    REGISTRY_CREDENTIALS = 'docker-credentials' // <<-- Jenkins credentials id for Docker (username/password)
    GIT_CREDENTIALS = 'git-credentials'        // <<-- Jenkins credentials id for Git (username/token or SSH)
  }

  stages {
    stage('Checkout') {
      steps {
        git credentialsId: "${GIT_CREDENTIALS}", url: 'https://github.com/<your-user>/<your-repo>.git'
      }
    }

    stage('Build Docker image') {
      steps {
        script {
          // tag with build number
          def imageTag = "${REGISTRY}:${env.BUILD_NUMBER}"
          dockerImage = docker.build(imageTag)
        }
      }
    }

    stage('Push Docker image') {
      steps {
        script {
          // push to Docker Hub (empty URL uses Docker Hub)
          docker.withRegistry('', "${REGISTRY_CREDENTIALS}") {
            dockerImage.push()
            dockerImage.push('latest')
          }
        }
      }
    }
  }

  post {
    always {
      echo "Build finished: ${currentBuild.fullDisplayName} - ${currentBuild.currentResult}"
    }
  }
}
