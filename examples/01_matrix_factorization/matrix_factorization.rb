require File.expand_path('../../../config/environment',  __FILE__)

# Comma separated list of user ratings
ratings = Examples.root + '/01_matrix_factorization/bullshit.csv'

# Perform the factorization and retrieve the user features
factorization = AlsFactorizer.new(ratings).factorize(1, 0.5, 99)
user_features = factorization.user_features
item_features = factorization.item_features

# Draw the results
userchart = ScatterChart.new(user_features)
userchart.save(Examples.root + '/01_matrix_factorization/user_features.html')
itemchart = ScatterChart.new(item_features)
itemchart.save(Examples.root + '/01_matrix_factorization/item_features.html')
p user_features
p item_features
