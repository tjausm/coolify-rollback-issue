**Step 1: Shallow clone enabled (default)**

Deploying works fine. Making changes and redeploying works fine. When attempting to rollback:

```
Starting deployment of tjausm/coolify-rollback-issue:main-d0c888ko8c8wwgk4owckck08 to localhost.
Preparing container with helper image: ghcr.io/coollabsio/coolify-helper:1.0.12
----------------------------------------
Importing tjausm/coolify-rollback-issue:main (commit sha 0558df0868dc8219734305e16b3225d074827853) to /artifacts/us8c48koo8wkg40swkkoggcc.
========================================
Deployment failed: Command execution failed (exit code 128): docker exec us8c48koo8wkg40swkkoggcc bash -c 'cd /artifacts/us8c48koo8wkg40swkkoggcc && git log -1 0558df0868dc8219734305e16b3225d074827853 --pretty=%B'
Error: fatal: bad object 0558df0868dc8219734305e16b3225d074827853
========================================
Gracefully shutting down build container: us8c48koo8wkg40swkkoggcc
```

**Step 2: Shallow clone disabled**

Workaround: deselect shallow clone in advanced options. Rollback now "completes":

```
Starting deployment of tjausm/coolify-rollback-issue:main-d0c888ko8c8wwgk4owckck08 to localhost.
Preparing container with helper image: ghcr.io/coollabsio/coolify-helper:1.0.12
----------------------------------------
Importing tjausm/coolify-rollback-issue:main (commit sha 329ffddc2e50212daaace057b06660bb96d4f37b) to /artifacts/ncwc0k08ss0ggoco4skkgc0w.
Added 2 ARG declarations to Dockerfile for service app1.
Service app2: All required ARG declarations already exist.
Pulling & building required images.
Adding build arguments to Docker Compose build command.
Removing old containers.
Starting new application.
New container started.
Gracefully shutting down build container: ncwc0k08ss0ggoco4skkgc0w
```

But it does not actually rollback - it redeploys the latest image. Container logs indicate the newest version is actually running instead of the rolled-back version.

Older images are available (confirmed via `docker images -a` in the Coolify terminal, rollback limit set to 20).

## Steps to Reproduce

1. Setup repo via GitHub app with docker compose
2. Deploy
3. Make a change (e.g. update version in Dockerfile), commit, deploy
4. Attempt to rollback
5. We get bad object error
6. Disable shallow clone in project -> advanced settings
7. attempt to rollback
8. Nothing happens
