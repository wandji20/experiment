module PlatesHelper
  def plate_template_partial_path(plate_size)
    return  "plates/96_plate" if plate_size == 96
    return  "plates/384_plate" if plate_size == 384
    return 'shared/empty'
  end

  def well_text(well)
    well[0] rescue nil
  end

  def well_color(well)
    well[1] rescue ''
  end
end