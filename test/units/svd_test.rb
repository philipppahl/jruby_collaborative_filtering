require File.expand_path('../../test_helper', __FILE__)

class SvdTest < Test::Unit::TestCase
    
  should "read single rating from file" do
    csv = save_csv([[0,0,1]])
    svd = Svd.new csv
    assert_equal 1, svd.rating_matrix[0][0]
  end
  
  should "generate the rating matrix from several ratings" do
    csv = save_csv([
      [0,0,1],
      [0,3,5],
      [6,0,2],
      [6,2,3]])
    svd = Svd.new csv
    assert_equal 1, svd.rating_matrix[0][0]
    assert_equal 5, svd.rating_matrix[0][3]
    assert_equal 2, svd.rating_matrix[6][0]
    assert_equal 3, svd.rating_matrix[6][2]
  end
  
  should "transform the rating matrix into dense matrix" do
    csv = save_csv([[1,1,1]])
    svd = Svd.new csv
    assert_equal 1, svd.dense_matrix.get(1,1)
    assert_equal 0, svd.dense_matrix.get(0,0)
  end
  
  should "have the correct number of users" do
    csv = save_csv([[2,0,1],[0,0,1]])
    svd = Svd.new csv
    assert_equal 3, svd.num_users
  end
  
  should "have the correct number of items" do
    csv = save_csv([[2,2,1],[0,0,1]])
    svd = Svd.new csv
    assert_equal 3, svd.num_items
  end
  
  should "produce a 3x3 user tranformation matrix" do
    csv = save_csv([[2,2,1],[0,0,1]])
    svd = Svd.new csv
    p svd.u.to_s
    assert_equal 3, svd.u.row_size
    assert_equal 3, svd.u.column_size
  end
  
  should "produce a 2x2 item tranformation matrix" do
    csv = save_csv([[2,1,1],[0,0,1]])
    svd = Svd.new csv
    p svd.v.to_s
    assert_equal 2, svd.v.row_size
    assert_equal 2, svd.v.column_size
  end
  
  
  def save_csv csv
    filename = "/tmp/#{rand}"  
    CSV.open(filename, 'w') do |writer|
      csv.each{|values| writer << values }
    end
    filename
  end
  
end