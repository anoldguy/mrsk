class Mrsk::Commands::Builder::Base < Mrsk::Commands::Base
  delegate :argumentize, to: Mrsk::Utils

  def pull
    docker :pull, config.absolute_image
  end

  def build_args
    argumentize "--build-arg", args, redacted: true
  end

  def build_secrets
    argumentize "--secret", secrets.collect { |secret| [ "id", secret ] }
  end

  def build_tags
    [ "-t", config.absolute_image, "-t", config.latest_image ]
  end

  private
    def args
      (config.builder && config.builder["args"]) || {}
    end

    def secrets
      (config.builder && config.builder["secrets"]) || []
    end
end
