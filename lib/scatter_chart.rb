class ScatterChart
    
  attr_accessor :title, :v_axis, :h_axis
  
  def initialize data=nil
    @data_columns ||= []
    @data_columns << {:title => 'data', :data => data} if data
  end
  
  def html
    raise 'No data given to draw' unless @data_columns
    
    <<-HTML
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>
      Google Visualization API Sample
    </title>
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load('visualization', '1', {packages: ['corechart']});
    </script>
    <script type="text/javascript">
      function drawVisualization() {
        // Create and populate the data table.
        #{data_table}
        // Create and draw the visualization.
        var chart = new google.visualization.ScatterChart(
          document.getElementById('visualization'));
        chart.draw(data, {title: #{title},
                      width: 600, height: 400,
                      vAxis: {title: #{v_axis}},
                      hAxis: {title: #{h_axis}}}
              );
}
      google.setOnLoadCallback(drawVisualization);
    </script>
  </head>
  <body style="font-family: Arial;border: 0 none;">
    <div id="visualization" style="width: 600px; height: 400px;"></div>
  </body>
</html>
    HTML
  end
  
  def v_axis
    @v_axis ? "\'#{@v_axis}\'" : "\'Y\'"
  end

  def h_axis
    @h_axis ? "\'#{@h_axis}\'" : "\'X\'"
  end
  
  def title
    @title ? "\'#{@title}\'" : "\'Data\'"
  end
  
  def data_table
    <<-HTML
      var data = new google.visualization.DataTable();
      data.addColumn('number', 'X');
      #{data_columns}
      #{data_rows}
    HTML
  end
  
  def data_columns
    @data_columns.inject(''){|memo, col| memo << "data.addColumn('number',\'#{col[:title]}\');"; memo}
  end
  
  def data_rows
    rows = ''
    @data_columns.each_with_index{|col, idx|
      col[:data].each{|row| rows << "data.addRow(#{data_row_at_index_and_size(row, idx+1, @data_columns.size+1)});"}
    }
    rows
  end
  
  def data_row_at_index_and_size row, idx, size
    data_row      = Array.new(size, 'null')
    data_row[0]   = row[0]
    data_row[idx] = row[1]
    "[#{data_row.join(',')}]"
  end
  
  def add_data_column col
    @data_columns << col
  end
  
  def data
    @data.map{|k| "[#{k[0]},#{k[1]}]"}.join(',')
  end
  
  def save filename
    puts "Save scatter chart to: #{filename}"
    File.open(filename, 'w'){|file|
      file.puts html
    }
  end
end
