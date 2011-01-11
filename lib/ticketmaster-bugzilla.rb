require File.dirname(__FILE__) + '/bugzilla/bugzilla-api.rb'

%w{ bugzilla ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end

