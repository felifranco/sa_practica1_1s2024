$ docker pull ubuntu

$ docker run -it --name ubuntu_test ubuntu /bin/bash

$ docker start ubuntu_test && docker exec -it ubuntu_test /bin/bash


