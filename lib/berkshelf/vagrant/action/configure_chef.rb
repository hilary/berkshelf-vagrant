module Berkshelf
  module Vagrant
    module Action
      # @author Jamie Winsor <reset@riotgames.com>
      class ConfigureChef
        include Berkshelf::Vagrant::EnvHelpers

        def initialize(app, env)
          @app = app
        end

        def call(env)
          if chef_solo?(env) && env[:berkshelf].shelf
            provisioners(:chef_solo, env).each do |provisioner|
              provisioner.config.cookbooks_path = provisioner.config.send(:prepare_folders_config, env[:berkshelf].shelf)
            end
          end

          @app.call(env)
        end
      end
    end
  end
end
