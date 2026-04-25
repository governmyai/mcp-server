# Dockerfile for the GovernMy MCP server.
#
# Used by registry sandboxes (Glama, etc.) to run the server in isolation.
# Real users normally invoke this via `npx @governmyai/mcp-server` from
# their MCP client config — Docker is not required for normal operation.

FROM node:20-alpine

WORKDIR /app

# Install only the runtime dependencies — copy the lockfile to ensure we
# install the same versions that have been tested and published.
COPY package.json package-lock.json* ./
RUN npm ci --omit=dev --no-audit --no-fund

# Copy the runtime source (matches what's published in the npm tarball).
COPY src ./src
COPY bin ./bin

# Server speaks MCP over stdio. The MCP_TRANSPORT env var lets Glama and
# similar sandboxes signal stdio mode explicitly; the server already defaults
# to stdio so this is informational.
ENV MCP_TRANSPORT=stdio

# GOVERNMY_API_KEY must be supplied at runtime by the MCP client config.
# The server starts without one (so introspection succeeds) and surfaces the
# missing-key error at the first tool call that needs the API.
ENTRYPOINT ["node", "src/index.js"]
