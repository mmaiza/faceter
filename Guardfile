# encoding: utf-8

guard :rspec, cmd: "bundle exec rspec" do

  watch(%r{^spec/.+_spec\.rb$})

  watch(%r{^lib/faceter/transproc(.+)\.rb$}) do |m|
    "spec/unit/transproc#{m[1]}"
  end

  watch(%r{^lib/faceter/nodes/(.+)\.rb$}) do |m|
    "spec/integration/transformations/#{m[1]}_spec.rb"
  end

  watch("lib/faceter.rb")      { "spec" }
  watch("spec/spec_helper.rb") { "spec" }

end # guard :rspec
