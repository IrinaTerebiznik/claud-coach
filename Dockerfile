FROM node:lts

RUN npm install -g @anthropic-ai/claude-code

# ANTHROPIC_API_KEY must be passed at runtime via -e ANTHROPIC_API_KEY
WORKDIR /plugin
