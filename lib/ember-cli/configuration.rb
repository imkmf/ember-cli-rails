require "singleton"

module EmberCLI
  class Configuration
    include Singleton

    def app(name, **options)
      apps.store name, BuildServer.new(name, **options)
    end

    def apps
      @apps ||= HashWithIndifferentAccess.new
    end

    def tee_path
      return @tee_path if defined?(@tee_path)
      @tee_path = Helpers.which("tee")
    end

    def ember_path
      @ember_path ||= Helpers.which("ember").tap do |path|
        fail "ember-cli executable could not be found" unless path
      end
    end

    attr_writer :ember_path
  end
end
