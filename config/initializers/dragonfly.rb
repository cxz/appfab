require 'dragonfly'

Dragonfly[:files].tap do |dragonfly_app|
  dragonfly_app.configure_with(:imagemagick)
  dragonfly_app.configure_with(:rails)
  dragonfly_app.define_macro(ActiveRecord::Base, :file_accessor)
  dragonfly_app.datastore = StoredFile::DataStore.new
end


Socialp::Application.config.middleware.insert 0, 'Rack::Cache', {
  :verbose     => true,
  # :metastore   => URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/meta"),
  # :entitystore => URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/body")
} # unless Rails.env.production?
  # uncomment the 'unless' with Rails3 ?

Socialp::Application.config.middleware.insert_after 'Rack::Cache', 
  'Dragonfly::Middleware', :files