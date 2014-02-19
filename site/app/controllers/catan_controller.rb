class CatanController < ApplicationController

  skip_before_action :verify_authenticity_token

  def update
    system("/home/deploy/catan/update_server.sh")

    render nothing: true
  end
end
