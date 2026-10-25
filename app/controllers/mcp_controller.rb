class McpController < ApplicationController
  def handle
    server = MCP::Server.new(name: "ScryFallMcp", tools: [ FindCardTool, SearchCardTool ])
    render json: server.handle_json(request.body.read)
  end
end
