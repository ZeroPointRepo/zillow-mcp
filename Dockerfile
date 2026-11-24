# Glama build for this listing. ZillAPI's MCP server is hosted at
# https://api.zillapi.com/mcp; this image only runs a stdio proxy to it
# (mcp-remote), so MCP clients that need a local command can inspect it.
#
# Set ZILLAPI_API_KEY (from https://zillapi.com/app/keys/) as an environment
# variable in the build settings. No key is stored in this repository.
FROM node:22.23.4-alpine
RUN npm install -g --ignore-scripts mcp-remote@0.16.7 && npm cache clean --force
USER node
WORKDIR /home/node
# The key goes into a private header file, not onto the command line.
ENTRYPOINT ["/bin/sh", "-c", "[ -n \"$ZILLAPI_API_KEY\" ] || { echo 'Set ZILLAPI_API_KEY to a ZillAPI API key (https://zillapi.com/app/keys/).' >&2; exit 1; }; umask 077; printf 'Authorization: Bearer %s\\n' \"$ZILLAPI_API_KEY\" > /tmp/zillapi-headers; exec mcp-remote https://api.zillapi.com/mcp --transport http-only --header-file /tmp/zillapi-headers"]
