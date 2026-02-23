FROM alpine:latest

RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'echo "Container v2 has started"' >> /entrypoint.sh && \
    echo 'sleep infinity' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
