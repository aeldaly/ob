class YieldSpread

  def initialize(bonds)
    fail_type_and_exit unless bonds.is_a?(Array)
    fail_size_and_exit unless bonds.size >= 2

    @bonds = bonds.sort_by { |h| -h[:term] }
  end

  def calculate
    [header, info].join("\n")
  end

  private

  def fail_type_and_exit
    output "You must pass in an array. Please try again."
    exit
  end

  def fail_size_and_exit
    output "Not enough inputs. Please ensure that you pass in at least 2 bonds."
    exit
  end

  def header
    "bond,benchmark,spread_to_benchmark"
  end

  def info
    info = "#{first_bond[:name]},#{second_bond[:name]},#{yield_diff}%"
  end

  def smallest_delta_index
    return @index if @index

    terms = @bonds.map { |h| h[:term] }
    deltas = []

    terms.each_with_index { |v, index| deltas << (index == 0 ? v : v - terms[index - 1]).abs }
    smallest_yield_diff = deltas.min
    @index = deltas.index(smallest_yield_diff)
  end

  def first_bond
    @first_bond ||= @bonds[smallest_delta_index - 1]
  end

  def second_bond
    @second_bond ||= @bonds[smallest_delta_index]
  end

  def yield_diff
    (first_bond[:yield] - second_bond[:yield]).round(2)
  end

  def output(message)
    @error = message
    puts @error
  end
end

if ARGV.first.nil?
  puts "ERROR!\n======"
  puts "You must supply an argument. Example:\n\n"
  puts "ruby ./yield_spread.rb \"[{ name: 'C1', type: 'corporate', term: 10.3, yield: 5.3 }, { name: 'G1', type: 'government', term: 9.4, yield: 3.7 }, { name: 'G2', type: 'government', term: 12, yield: 4.8 }, { name: 'G3', type: 'government', term: 15, yield: 4.8 }]\""
  exit
end

puts YieldSpread.new(eval(ARGV.first)).calculate
