# kasmweb-mega

from https://hub.docker.com/r/kasmweb/desktop
+ added megasync client

https://kasmweb.com/docs/latest/how_to/building_images.html?utm_campaign=Dockerhub&utm_source=docker


The container is now accessible via a browser : https://IP_ADDRESS:6901

port 6901

ex. https://127.0.0.1:6901/
  
sudo docker run --rm -it --shm-size=512m -p 6901:6901 -e VNCOPTIONS=-disableBasicAuth lordcris/kasmweb-mega:rolling

.

## Docker Compose option

If you prefer a reverse-proxy front end with automatic TLS, use the provided `docker-compose.yml` and `Caddyfile`.

### Features
- MEGAsync desktop client available on first login.
- Caddy reverse proxy terminates HTTPS using Let's Encrypt certificates.
- Compose stack pulls the latest images each time with `pull_policy: always`.

### Requirements
- Docker Engine 20.10+ with the Compose plugin.
- A DNS record pointing at your host (set in `.env`).
- Ports 80 and 443 forwarded to the Docker host; keep any DNS proxy (for example Cloudflare) in "DNS only" mode until the certificate is issued.

### Quick start
1. Clone the repo and change into it: `git clone https://github.com/lordcris/kasmweb-mega && cd kasmweb-mega`.
2. Create `.env` (ignored by git) with your values:
   ```env
   DOMAIN=your.domain.example.com
   ACME_EMAIL=you@example.com
   ```
3. Start the stack: `docker compose up -d`.
4. Watch the logs if needed: `docker compose logs -f caddy`.
5. Browse to `https://your.domain.example.com` once the certificate loads.

### Daily updates
- The upstream image updates frequently; `docker compose up` will fetch the newest build before starting.
- Stop everything with `docker compose down` (removes containers, keeps images and volumes).

### Optional cleanup
- After shutting down, run `docker system prune -a --volumes` manually if you want to reclaim all Docker resources.

## References
- Upstream Kasm documentation: https://kasmweb.com/docs/latest/how_to/building_images.html


