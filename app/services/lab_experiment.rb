class LabExperiment
  def initialize(plate_size, samples, reagents, repeats)
    @plate_size = plate_size
    @samples = samples
    @reagents = reagents
    @repeats = repeats
    well_counts
    @plates = Array.new(number_of_plates) { Array.new(plate_row) { Array.new(plate_column)} }
  end

  def display_plates
    handle_assign_wells
    @plates.each_with_index do |plate, index|
      p "Plate: #{index + 1}"
      plate.each do |plate_row|
        p plate_row
      end
    end
  end

  def assign_wells
    handle_assign_wells
  end
  
  private
  def well_counts
    @well_counts ||= count_wells
  end
  
  def handle_assign_wells
    @added_well_counts = 0

    all_reagents = @reagents.flatten
  
    all_reagents.each do |reagent_value|
      @repeats.each_with_index do |repeat_value, index|
        current_reagents = @reagents[index]
        # Next when reagent_value in not included in current_reagents
        next unless current_reagents.include?(reagent_value)
        current_samples = @samples[index]
        handle_add_well(current_samples, current_reagents, repeat_value, reagent_value)
      end
    end
    @plates
  end

  def handle_add_well(samples, reagents, repeat_value, reagent_value)
    return unless reagents.include?(reagent_value)

    samples.product([reagent_value]) do |well|
      repeat_value.times do |number|
        plate_index = @added_well_counts / plate_area
        
        plate_well_counts = @added_well_counts % plate_area
        row = plate_well_counts / plate_column

        column = row.even? ? 
                    @added_well_counts % plate_column : 
                    plate_column - (@added_well_counts % plate_column) - 1
        @added_well_counts
        @added_well_counts += 1
        add_well(plate_index, well, row, column)
      end
    end
  end

  def add_well(plate, well, row, column)
    @plates[plate][row][column] = well
  end
  
  def count_wells
    counts = 0
    @repeats.each_with_index do |value, index|
      counts += (@samples[index].length * @reagents[index].length * value)
    end
    counts
  end

  def number_of_plates
    (well_counts / @plate_size.to_f).ceil
  end

  def plate_row
    @plate_size == 96 ? 8 : 16    
  end

  def plate_column
    @plate_size == 96 ? 12 : 24
  end

  def plate_area
    plate_column * plate_row
  end
end

