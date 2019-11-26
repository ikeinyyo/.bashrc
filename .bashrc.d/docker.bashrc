dbuild() {
    docker build -t $1 .    
}

dbtp() {
    docker build -t $2 .    
    docker tag  $2 $1/$2
    docker push $1/$2
}

dstop() {
    docker stop $(docker ps -a -q)
}

dremove() {
    docker rm $(docker ps -a -q)
}

diremove() {
    docker rmi $(docker images -q) -f
}