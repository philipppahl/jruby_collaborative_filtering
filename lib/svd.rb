class Svd
  
  attr_accessor :rating_matrix
  
  def initialize ratings
    @rating_matrix = read_ratings(ratings)
  end
  
  def dense_matrix
    dense_matrix = DenseMatrix.new(num_users,  num_items)
    @rating_matrix.each_with_index do |row, row_idx|
      row.each_with_index do |rating, col_idx|
        dense_matrix.set_quick(row_idx, col_idx, rating) if rating
      end if row
    end
    dense_matrix
  end
  
  def num_users
    @rating_matrix.size
  end
  
  def num_items
    @rating_matrix.inject(0) do |num_items, items| 
      num_items = items.size if items and items.size > num_items
      num_items
    end
  end
    
  def u
    ruby_matrix(decomposition.u)
  end 
  
  def v_inv
    ruby_matrix(decomposition.v.transpose)
  end
  
  def ruby_matrix matrix
    m = []
    matrix.row_size.times{|row_idx| 
      row = matrix.view_row(row_idx)
      ruby_row = []
      row.size.times{|col_idx| 
        num = row.element(col_idx).get
        ruby_row << num
      }
      m << ruby_row
    }
    m
  end
  
  def decomposition
    @decomposition ||= SingularValueDecomposition.new(dense_matrix)
  end
  
  def read_ratings ratings
    rating_matrix = []
    CSV.foreach(ratings) do |row| 
      user = row[0].to_i
      item = row[1].to_i
      rating = row[2].to_f
      rating_matrix[user] ||= []
      rating_matrix[user][item] = rating
    end
    rating_matrix
  end
  
end