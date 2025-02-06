from https://hub.docker.com/r/kasmweb/desktop
+ added megasync client

https://kasmweb.com/docs/latest/how_to/building_images.html?utm_campaign=Dockerhub&utm_source=docker


The container is now accessible via a browser : https://IP_ADDRESS:6901

port 6901

ex. https://127.0.0.1:6901/
  
sudo docker run --rm -it --shm-size=512m -p 6901:6901 -e VNCOPTIONS=-disableBasicAuth lordcris/kasmweb-mega:rolling




