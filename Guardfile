# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, all_on_start: true, all_after_pass: true, failed_mode: :keep do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

