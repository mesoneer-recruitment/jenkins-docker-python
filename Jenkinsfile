pipeline {
	agent {
		label ubitecSlaves.commonFleet()
	}

	options {
		buildDiscarder(logRotator(daysToKeepStr: '14', numToKeepStr: '5'))
	}

	parameters {
		string(name: 'version', defaultValue: '0.1.0', description: 'Define version of the image.', trim: true)
	}

	stages {
		stage('Check out source code') {
			steps {
				checkout([$class: 'GitSCM',
					branches: [[name: '*/master']],
					extensions: [[$class: 'WipeWorkspace']],
					userRemoteConfigs: [[url: 'git@bitbucket.org:ubitecag/jenkins-docker-python.git']]
				])
			}
		}

		stage('Build Docker image') {
			steps {
				echo "[INFO] Start building Docker image."
				script {
					def customImage = docker.build("jenkins-docker-python:${params.version}", "--label version=${params.version} --tag 031813119665.dkr.ecr.ap-southeast-1.amazonaws.com/io.ubitec/jenkins-docker-python:${params.version} .")
					sh '$(aws ecr get-login --no-include-email --region ap-southeast-1)'
					sh "docker push 031813119665.dkr.ecr.ap-southeast-1.amazonaws.com/io.ubitec/jenkins-docker-python:${params.version}"
				}
			}
		}
	}
}
