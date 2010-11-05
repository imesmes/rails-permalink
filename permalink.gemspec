Gem::Specification.new do |s|
  s.name = 'permalink'
  s.version = '1.0.0'
  s.author = 'Francesc Esplugas'
  s.email = 'francesc@intraducibles.com'
  s.summary = 'Permalink'

  s.add_dependency('rails', '>= 3.0.0')

  s.files = Dir['lib/**/*']
  s.require_path = 'lib'
end
