## Docker Compose Services

This repository is organized as one folder per service so you can deploy each stack independently.

### Services added
- `nginx-proxy-manager/`
- `traefik/`
- `portainer/`
- `monitoring/`
- `gitea/`
- `pyrodactyl/`
- `mercure-hub/`

### Shared proxy network
Each stack defines a Docker network named `proxy`.

For any future app stack in this repo, join the same network as external:

```yaml
networks:
  proxy:
    external: true
    name: proxy
```

### Usage
1. In each service folder you deploy, copy that folder's `.env.example` to `.env` and set real values.
2. Pick your reverse proxy (`nginx-proxy-manager` or `traefik`) and start it.
3. Start any additional stacks:

```bash
cd <folder>
docker compose up -d
```

Do not run Nginx Proxy Manager and Traefik at the same time on one host, because both bind ports `80` and `443`.
