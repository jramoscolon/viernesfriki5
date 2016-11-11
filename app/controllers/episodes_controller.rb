class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /episodes
  # GET /episodes.json
  def index
    @episodes = Episode.all
  end

  # GET /episodes/1
  # GET /episodes/1.json
  def show
  end

  # GET /episodes/new
  def new
    @episode = Episode.new
  end

  # GET /episodes/1/edit
  def edit
  end

  # POST /episodes
  # POST /episodes.json
  def create
    @episode = Episode.new(episode_params)
    @episode.user = current_user
    if @episode.save
      flash[:success] = "Article was successfully created"
      redirect_to episode_path(@episode)
    else
      render 'new'
    end
  end

  # PATCH/PUT /episodes/1
  # PATCH/PUT /episodes/1.json
  def update
    if @episode.update(episode_params)
      flash[:success] = "Episode was successfully updated"
      redirect_to episode_path(@episode)
    else
      render 'edit'
    end
  end



  # DELETE /episodes/1
  # DELETE /episodes/1.json
  def destroy
    @episode.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to episodes_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def episode_params
      params.require(:episode).permit(:title, :body, :image_url)
    end

    def require_same_user
      if current_user != @episode.user
        flash[:danger] = "You can only edit or delete your wn articles"
        redirect_to root_path
      end
    end
end
