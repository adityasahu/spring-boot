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
    - name: docker
      image: docker
      command:
      - cat
      tty: true
      volumeMounts:
      - mountPath: "/var/run/docker.sock"
        name: "workspace-volume"
        readOnly: false
      volumes:
      - hostPath:
         path:"/var/run/docker.sock"
        name: "workspace-volume"

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
    stage("Deploy on GKE") {
            steps {
              container('kubectl') {
              sh "sed -i s#gcr.io/gcp-terraform-315220/hello-world#${IMAGE_TAG}#g ./k8s/deployment.yaml"
          step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT, clusterName: env.CLUSTER, location: env.CLUSTER_ZONE, manifestPattern: './k8s/deployment.yaml', credentialsId: env.JENKINS_CRED, verifyDeployments: true])
          }
            }
    }



}
}
