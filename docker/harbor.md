# Basic commands to build and install a Docker image on the UB registry

```bash
docker login registry.u-bordeaux.fr
docker build -t registry.u-bordeaux.fr/tthor/alpine-git .
docker push registry.u-bordeaux.fr/tthor/alpine-git
```
