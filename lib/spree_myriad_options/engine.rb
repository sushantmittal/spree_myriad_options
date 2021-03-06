module SpreeMyriadOptions
  class Engine < Rails::Engine
    # TODO this is a hack to getaround a spree namespace issue, see GH#1580
    module Spree; end
    require 'spree/core'

    engine_name 'spree_myriad_options'
    isolate_namespace Spree

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
