# frozen_string_literal: true

module Plots
  class Daily
    def self.call
      Gnuplot.open do |gp|
        Gnuplot::Plot.new(gp) do |plot|
          plot.title  'Array Plot Example'
          plot.xlabel 'Date'
          plot.ylabel 'Amount'
          plot.timefmt "'%Y-%m-%d'"
          plot.xdata 'time'
          plot.style 'data lines'
          plot.format "x '%m-%d'"
          plot.set 'offset 1,1,1,1'
          plot.set 'key box opaque'
          plot.style 'textbox opaque'

          x = Report.last(7).map { |report| report.to.to_date }
          y = Report.last(7).map { |report| report.expenses.where(category_id: 2).sum(:amount).abs.to_f }

          plot.data << Gnuplot::DataSet.new([x, y]) do |ds|
            ds.notitle
            ds.with = 'linespoints'
            ds.linewidth = '3'
            ds.using = '1:2:xtic(3)'
          end

          plot.data << Gnuplot::DataSet.new([x, y]) do |ds|
            ds.linewidth = '5'
            ds.using = '1:2:2 w labels center boxed notitle'
          end
        end
      end
    end
  end
end
