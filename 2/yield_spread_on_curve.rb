class YieldSpreadOnCurve

  def initialize(bonds)
    fail_type_and_exit unless bonds.is_a?(Array)
    fail_size_and_exit unless bonds.size >= 3

    @corporate_bonds = bonds.select{|h| h[:type] == "corporate"}.sort_by { |h| -h[:term] }
    @government_bonds = bonds.select{|h| h[:type] == "government"}.sort_by { |h| -h[:term] }
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
    output "Not enough inputs. Please ensure that you pass in at least 3 bonds."
    exit
  end

  def header
    "bond,spread_to_curve"
  end

  def info
    [].tap do |info|
      @corporate_bonds.reverse.each do |bond|
        info << "#{bond[:name]},#{interpolated_value_for(bond)}%"
      end
    end.join("\n")
  end

  def interpolated_value_for(bond)
    one, two = get_gov_bonds_on_either_side_of(bond)

    slope = (one[:yield] - two[:yield]) / (one[:term] - two[:term])
    b = one[:yield] - slope * one[:term]

    yield_on_curve = (slope * bond[:term] + b).round(2)
  end

  def get_gov_bonds_on_either_side_of(bond)
    one = @government_bonds.select { |h| h[:term] < bond[:term] }.first
    two = @government_bonds.select { |h| h[:term] > bond[:term] }.first

    [one, two]
  end

  def output(message)
    @error = message
    puts @error
  end
end

puts YieldSpreadOnCurve.new(eval(ARGV.first)).calculate
