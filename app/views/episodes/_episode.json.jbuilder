json.extract! episode, :id, :title, :body, :image_url, :created_at, :updated_at
json.url episode_url(episode, format: :json)