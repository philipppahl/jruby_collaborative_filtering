require File.expand_path('../../../config/environment',  __FILE__)

# Comma separated list of user ratings
ratings = Examples.root + '/01_matrix_factorization/ratings.csv'

# Perform the factorization and retrieve the user features
factorization = AlsFactorizer.new(ratings).factorize(2, 0.04, 5)
user_features = factorization.user_features

# Draw the results
chart = ScatterChart.new(user_features)
chart.save(Examples.root + '/01_matrix_factorization/user_features.html')
