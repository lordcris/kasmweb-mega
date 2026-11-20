# kasmweb-mega

Based on `kasmweb/core-ubuntu-noble` (Ubuntu 24.04).
Includes the MEGAsync desktop client.

## Usage

### Docker Run

```bash
sudo docker run --rm -it --shm-size=512m -p 6901:6901 -e VNCOPTIONS=-disableBasicAuth lordcris/kasmweb-mega:latest
```



The container is now accessible via a browser : https://IP_ADDRESS:6901

port 6901

ex. https://127.0.0.1:6901/

.

## Docker Compose option (Cloudflare Tunnel + Access)

`docker-compose.yml` runs Kasm behind a Cloudflare Tunnel. No inbound ports are opened on the host;
`cloudflared` makes an outbound connection to Cloudflare, which serves HTTPS on your domain and puts
a Cloudflare Access login in front of it. Kasm itself runs without VNC auth (`-disableBasicAuth`),
so **Access is the only thing protecting the desktop** - never publish the hostname without an Access policy.

### Setup
1. In the Cloudflare dashboard, go to Networking > Tunnels and create a tunnel (type cloudflared). Copy its token.
2. Add a published application route to the tunnel: your hostname -> `https://kasm:6901`,
   with TLS > "Disable TLS certificate verification" on (Kasm uses a self-signed certificate).
3. In Zero Trust > Access controls > Applications, add a self-hosted application for the same hostname
   with an Allow policy for your email(s).
4. Create `.env` (ignored by git):
   ```env
   TUNNEL_TOKEN=your-tunnel-token
   ```
5. Start the stack: `docker compose up -d`, and check `docker compose logs -f cloudflared`.
6. Make sure no router port forwarding points at this host; it isn't needed.

### Daily updates
- `pull_policy: always` makes `docker compose up` fetch the newest images before starting.
- Stop everything with `docker compose down` (removes containers, keeps images).

### Optional cleanup
- After shutting down, run `docker system prune -a --volumes` manually if you want to reclaim all Docker resources.

## References
- Upstream Kasm documentation: https://kasmweb.com/docs/latest/how_to/building_images.html

