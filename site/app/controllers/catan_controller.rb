class CatanController < ApplicationController

  def update
    `/home/deploy/catan/update_server.sh`

    render nothing: true
  end
end
