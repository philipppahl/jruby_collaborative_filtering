require File.expand_path('../../../config/environment',  __FILE__)

# Comma separated list of user ratings
ratings = Examples.root + '/01_matrix_factorization/ratings.csv'

svd = Svd.new ratings

# get the user transformation matrix
p user_rows = svd.u.map{|row| row.first(2)}
ScatterChart.new(user_rows).save(Examples.root + '/02_simple_svd/user.html')
