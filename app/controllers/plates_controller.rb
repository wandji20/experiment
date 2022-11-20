class PlatesController < ApplicationController
  def index
    @plates = nil
    @plate_size = params[:plate_size].to_i rescue nil
  
    # s = [["S-1", "S-2", "S-3", "S-4", "S-5"], ["S-1", "S-2", "S-3"]]
    s = [['Sample-1', 'Sample-2', 'Sample-3'], ['Sample-1', 'Sample-2', 'Sample-3']]
    # r = [['Pink', 'Blue'], ['Green', 'Red', 'Yellow']]
    r = [['Pink'], ['Green']]
    # re = [3, 4]
    re = [3, 2]
  
    @samples = eval(params[:samples]) rescue nil
    # p @samples = JSON.generate(params[:samples]) rescue ""
    # p @samples = JSON.parse(params[:samples]) rescue nil
    # p @reagents = JSON.parse(params[:reagents]) rescue nil
    @reagents = eval(params[:reagents]) rescue nil
    # p @repeats = JSON.parse(params[:repeats]) rescue nil
    @repeats = eval(params[:repeats]) rescue nil

    if [@samples, @reagents, @repeats, @plate_size].all?(&:present?)
      begin
        experiment = LabExperiment.new(@plate_size, @samples, @reagents, @repeats)
        @plates = experiment.assign_wells  
      rescue => exception
        p exception
      end
    else
      @plate_size = 96
      experiment = LabExperiment.new(@plate_size, s, r, re)
      @plates = experiment.assign_wells  
    end
  end
end
