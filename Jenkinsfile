pipeline {
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
    serviceAccountName: gcp-terraform-315220-sa
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
      stage("Build") {
        steps {
          container('maven') {
              // build
              sh "mvn clean package"
      }
        }
}

}
}
