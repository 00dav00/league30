json.extract! team, :id, :short_name, :name, :full_name, :logo_image, :created_at, :updated_at
json.url team_url(team, format: :json)
