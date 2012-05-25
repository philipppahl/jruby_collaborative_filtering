$: << File.expand_path('../../lib',  __FILE__)
require 'java'

# load the mahout libraries
jars = [
  'mahout-core-0.6.jar', 
  'mahout-core-0.6-job.jar',
  'mahout-math-0.6',
  'slf4j-simple-1.6.4.jar'
  ]
  
jars.each{|jar| require File.expand_path("../../lib/java/#{jar}", __FILE__)}

class Examples
  class << self
    def root
      File.expand_path('../../examples', __FILE__)
    end
  end
end

java_import 'org.apache.mahout.cf.taste.impl.model.file.FileDataModel'
java_import 'org.apache.mahout.cf.taste.impl.recommender.svd.ALSWRFactorizer'

require 'als_factorizer'
require 'scatter_chart'



