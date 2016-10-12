module Scheduler
  module Model
    class Engine < ::Rails::Engine
      isolate_namespace Scheduler
      paths["app/views"] << "app/views/scheduler/model"

      initializer :append_migrations do |app|
        unless app.root.to_s.match(root.to_s)
          config.paths["db/migrate"].expanded.each do |p|
            app.config.paths["db/migrate"] << p
          end
        end
      end

      config.to_prepare do
        Dir.glob(Engine.root.join("app", "decorators", "**", "*_decorator*.rb")) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end

    end

  end
end


