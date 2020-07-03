#!/bin/bash
set -x
# export  MY_COMMIT_SHA=$(git log -1 --pretty=format:"%H" | awk '{print substr($1,1,8)}')
export DockerImageName=registry.cn-hangzhou.aliyuncs.com/${CI_PROJECT_NAMESPACE}/${CI_PROJECT_NAME}:v${CI_PIPELINE_IID}-${CI_PIPELINE_ID}
function maven_build(){
   mvn package -U -DskipTests=true
}

function helm_build(){
     # mkdir -p deploy
	 # cp -rf /root/deploy/java/deploy/* deploy
	 if [  -d "k8s" ];then
	 echo "存在自定义k8s 文件"
	 cp -rf k8s/* deploy/templates
	 fi
     cp -f values-${1}.yaml deploy/values.yaml
     helm template  deploy  --name ${ServiceName}-${CI_PIPELINE_IID} --namespace ${Namespace} \
      --set service.name=${ServiceName} --set time="x$(date +'%s')"  --set env.open.SPRING_PROFILES_ACTIVE=${1} \
      --set image.repository=${DockerImageName} > deploy.yaml
     cat deploy.yaml
}
docker_build(){
    pathJar=$(find target -name '*.jar'|head -n 1)
    jarName=${pathJar##*/}
    if [  -f "Dockerfile" ];then
    	echo "Dockerfile 存在 走本地"
    else
        echo "Dockerfile 不存在 走默认"
        cp -rf /root/deploy/java/docker/* .
    fi
    find . -name 'Dockerfile' | xargs sed -i "s jarName $jarName  g"
    docker build -t $DockerImageName .

}
deploy(){
     helm_build $1
	 kubectl --kubeconfig=config/dev/config apply -f deploy.yaml
}

