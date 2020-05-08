pipeline {
	agent {
		label ubitecSlaves.commonFleet()
	}

	options {
		buildDiscarder(logRotator(daysToKeepStr: '14', numToKeepStr: '5'))
	}

	stages {
		stage('Check out source code') {
			steps {
				checkout([$class: 'GitSCM',
					branches: [[name: '*/master']],
					extensions: [[$class: 'WipeWorkspace']],
					userRemoteConfigs: [[
						url: 'git@bitbucket.org:ubitecag/jenkins-docker-python.git',
						credentials: 'jenkins-ssh-private-key'
					]]
				])
			}
		}

		stage('Build Docker image') {
			steps {
				script {
					version = readFile file: 'VERSION'

					ubitecDockerRegistry {
						def pythonBase = docker.build "io.ubitec/jenkins-docker-python:base-${version}",
								"--label version=${version} --target=ubitec_jenkins_python_base ."

						pythonBase.push()

						def mkdocs = docker.build "io.ubitec/jenkins-docker-python:mkdocs-${version}",
								"--label version=${version} --target=ubitec_jenkins_mkdocs ."

						mkdocs.push()

					}
				}
			}
		}
	}
}
