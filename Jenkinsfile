pipeline {
    environment {
    PROJECT = "gcp-terraform-315220"
    APP_NAME = "hello-world"
    CLUSTER = "${PROJECT}-gke"
    CLUSTER_ZONE = "us-west1-a"
    IMAGE_TAG = "gcr.io/${PROJECT}/${APP_NAME}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
    JENKINS_CRED = "${PROJECT}"
  }
    agent {
      kubernetes {
        label 'hello world'
        yaml """
  apiVersion: v1
  kind: Pod
  metadata:
  labels:
    component: ci
  spec:
    # Use service account that can deploy to all namespaces
    containers:
    - name: maven
      image: maven:3.3.9-jdk-8-alpine
      command: ['cat']
      tty: true
    - name: gcloud
      image: gcr.io/cloud-builders/gcloud
      command:
      - cat
      tty: true
    - name: kubectl
      image: gcr.io/cloud-builders/kubectl
      command:
      - cat
      tty: true
  """
  }
	}

  stages {
      stage("Maven Build") {
        steps {
          container('maven') {
              // build
              sh "mvn clean package"
      }
        }
}
    stage("Docker Build") {
            steps {
              container('gcloud') {
                  // build
                  sh "gcloud builds submit -t ${IMAGE_TAG} . "
          }
            }
    }


}
}
