# base-container
base container Dockerfile 

commands:
1. container build: `podman build --build-arg USER_ID=$(id -u ${USER}) --build-arg GROUP_ID=$(id -g ${USER}) -t sconv:22.04 .`
1. container run: `podman run --rm -it --userns=keep-id -v /home/lucas.alvarenga/repositories/unified_sconv:/home/user/sconv/ -w /home/user sconv:22.04`
