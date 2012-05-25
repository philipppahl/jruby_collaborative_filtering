class AlsFactorizer
  
  # ratings point to the file of the user preferences
  def initialize ratings
    file = java.io.File.new(ratings)
    @data = FileDataModel.new(file)
  end
  
  # factorize the ratings
  # @param
  #   features:   number of features
  #   lambda:     regularization parameter
  #   iterations: number of iterations for the calculation
  def factorize(features, lambda, iterations)
    @factorization = ALSWRFactorizer.new(@data, features, lambda, iterations).factorize
    self
  end
  
  # get the user features
  def user_features
    raise 'Please call factorize before accessing the user features' unless @factorization
    
    @factorization.get_user_id_mappings.iterator.inject([]) do |user_matrix, user_map|
      user_matrix << @factorization.getUserFeatures(user_map.get_key.long_value).to_a
      user_matrix
    end
  end
  
  # get the user features
  def item_features
    raise 'Please call factorize before accessing the item features' unless @factorization
    
    @factorization.get_item_id_mappings.iterator.inject([]) do |item_matrix, item_map|
      item_matrix << @factorization.getItemFeatures(item_map.get_key.long_value).to_a
      item_matrix
    end
  end
  
  
end
