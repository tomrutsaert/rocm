# rocm
ubuntu rocm docker image


docker run example:

```
docker run --device /dev/kfd --device /dev/dri --security-opt seccomp=unconfined ghcr.io/tomrutsaert/rocm
```