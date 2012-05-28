require File.expand_path('../../../config/environment',  __FILE__)

# Comma separated list of user ratings
ratings = Examples.root + '/01_matrix_factorization/ratings.csv'

# Perform the factorization and retrieve the user features
factorization = AlsFactorizer.new(ratings).factorize(2, 0.05, 10)
user_features = factorization.user_features
item_features = factorization.item_features

# Draw the results
user_chart = ScatterChart.new(user_features)
user_chart.save(Examples.root + '/01_matrix_factorization/user_features.html')

item_chart = ScatterChart.new(item_features)
item_chart.save(Examples.root + '/01_matrix_factorization/item_features.html')

# Draw user and items in combined chart
combined_chart = ScatterChart.new
combined_chart.add_data_column({:title => 'User', :data => user_features})
combined_chart.add_data_column({:title => 'Items', :data => item_features})
combined_chart.title = 'Feature Space'
combined_chart.save(Examples.root + '/01_matrix_factorization/user_item_features.html')