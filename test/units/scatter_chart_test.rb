require File.expand_path('../../test_helper', __FILE__)

class ScatterChartTest < Test::Unit::TestCase
      
  should "generate the correct data rows for simple scatter chart" do
    chart = ScatterChart.new( [[1,2], [3,4]] )
    assert_equal 'data.addRow([1,2])', chart.data_rows.split(';').first
    assert_equal 'data.addRow([3,4])', chart.data_rows.split(';').last
  end
  
  should "generate a data column" do
    chart = ScatterChart.new
    chart.add_data_column({:title => 'column_1'})
    assert_equal "data.addColumn('number','column_1');", chart.data_columns
  end
  
  should "generate the correct data columns" do
    chart = ScatterChart.new
    chart.add_data_column({:title => 'column_1'})
    chart.add_data_column({:title => 'column_2'})
    assert_equal "data.addColumn('number','column_2')", chart.data_columns.split(';').last
  end
  
  should "have the correct data row" do
    chart = ScatterChart.new
    chart.add_data_column({:data => [[1,2]]})
    assert_equal "data.addRow([1,2]);", chart.data_rows
  end
  
  should "create the correct data row array" do
    assert_equal "[1,null,3]", ScatterChart.new.data_row_at_index_and_size([1,3], 2, 3)
  end
  
  
end