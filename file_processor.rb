#!/usr/bin/env ruby

require 'descriptive-statistics'

class FileProcessor
  include DescriptiveStatistics

  attr_accessor :file_name, :lines
  def initialize(file_name)
    @file_name = file_name
    @lines = []
  end

  def parse
    File.open(file_name) do |file|
      file.each_line do |line|
        save_line(line.strip.split(' '))
      end
    end
    self
  end

  def five_number_summary
    wb1 = []
    wb2 = []
    wb3 = []
    wb4 = []
    wb5 = []
    pb = []

    lines.each do |line|
      wb1.push(line['WB1'].to_i)
      wb2.push(line['WB2'].to_i)
      wb3.push(line['WB3'].to_i)
      wb4.push(line['WB4'].to_i)
      wb5.push(line['WB5'].to_i)
      pb.push(line['PB'].to_i)
    end

    all = (wb1+wb2+wb3+wb4+wb5)

    @wb1_stats = DescriptiveStatistics::Stats.new(wb1)
    @wb2_stats = DescriptiveStatistics::Stats.new(wb2)
    @wb3_stats = DescriptiveStatistics::Stats.new(wb3)
    @wb4_stats = DescriptiveStatistics::Stats.new(wb4)
    @wb5_stats = DescriptiveStatistics::Stats.new(wb5)
    @pb_stats  = DescriptiveStatistics::Stats.new(pb)
    @all_stats = DescriptiveStatistics::Stats.new(all)

    puts 'Five Number Summary, plus standard deviation'
    p "WB1. min: #{@wb1_stats.min}, max: #{@wb1_stats.max}, mean: #{@wb1_stats.mean}, median: #{@wb1_stats.median}, mode: #{@wb1_stats.mode}, standard deviation: #{@wb1_stats.standard_deviation}, "
    p "WB2. min: #{@wb2_stats.min}, max: #{@wb2_stats.max}, mean: #{@wb2_stats.mean}, median: #{@wb2_stats.median}, mode: #{@wb2_stats.mode}, standard deviation: #{@wb2_stats.standard_deviation}, "
    p "WB3. min: #{@wb3_stats.min}, max: #{@wb3_stats.max}, mean: #{@wb3_stats.mean}, median: #{@wb3_stats.median}, mode: #{@wb3_stats.mode}, standard deviation: #{@wb3_stats.standard_deviation}, "
    p "WB4. min: #{@wb4_stats.min}, max: #{@wb4_stats.max}, mean: #{@wb4_stats.mean}, median: #{@wb4_stats.median}, mode: #{@wb4_stats.mode}, standard deviation: #{@wb4_stats.standard_deviation}, "
    p "WB5. min: #{@wb5_stats.min}, max: #{@wb5_stats.max}, mean: #{@wb5_stats.mean}, median: #{@wb5_stats.median}, mode: #{@wb5_stats.mode}, standard deviation: #{@wb5_stats.standard_deviation}, "
    p "PB. min: #{@pb_stats.min}, max: #{@pb_stats.max}, mean: #{@pb_stats.mean}, median: #{@pb_stats.median}, mode: #{@pb_stats.mode}, standard deviation: #{@pb_stats.standard_deviation}, "
    p "ALL. min: #{@all_stats.min}, max: #{@all_stats.max}, mean: #{@all_stats.mean}, median: #{@all_stats.median}, mode: #{@all_stats.mode}, standard deviation: #{@all_stats.standard_deviation}, "

    item_printer("WB1", @wb1_stats)
    item_printer("WB2", @wb2_stats)
    item_printer("WB3", @wb3_stats)
    item_printer("WB4", @wb4_stats)
    item_printer("WB5", @wb5_stats)
    item_printer("PB",  @pb_stats)
    item_printer("All", @all_stats)

    self
  end

  def item_printer(name, variable)
    str = "#{name}: \n"
    str += "\t Printing 5 number summary with some extras \n"
    str += "\t\t min: #{variable.min} \n"
    str += "\t\t max: #{variable.max} \n"
    str += "\t\t mean: #{variable.mean} \n"
    str += "\t\t median: #{variable.median} \n"
    str += "\t\t mode: #{variable.mode} \n"
    str += "\t\t range: #{variable.range} \n"
    str += "\t\t skewness: #{variable.skewness} \n"
    str += "\t\t kurtosis: #{variable.kurtosis} \n"
    str += "\t Printing Spread: \n"
    str += "\t\t standard_deviation: #{variable.standard_deviation} \n"
    str += "\t\t variance: #{variable.variance} \n"
    str += "\t\t population_variance: #{variable.population_variance} \n"
    str += "\t\t relative_standard_deviation: #{variable.relative_standard_deviation} \n"
    puts str
    self
  end

private
  def save_line(line)
    object = {}
    # object['date'] = line[0]
    object['WB1'] = line[1]
    object['WB2'] = line[2]
    object['WB3'] = line[3]
    object['WB4'] = line[4]
    object['WB5'] = line[5]
    object['PB'] = line[6]
    object['PP'] = line[7] if line.length == 8

    lines.push(object)
  end

end

FileProcessor.new('history.txt').parse.five_number_summary
