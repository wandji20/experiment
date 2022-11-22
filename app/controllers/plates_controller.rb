class PlatesController < ApplicationController
  def index
    @plates = nil
    @plate_size = params[:plate_size].to_i rescue nil
  
    @samples = eval(params[:samples]) rescue nil
    @reagents = eval(params[:reagents]) rescue nil
    @repeats = eval(params[:repeats]) rescue nil

    if [@samples, @reagents, @repeats, @plate_size].all?(&:present?)
      begin
        experiment = LabExperiment.new(@plate_size, @samples, @reagents, @repeats)
        @plates = experiment.assign_wells  
      rescue => exception
        p exception
      end
    end
  end
end
