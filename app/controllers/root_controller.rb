require 'orf_finder'

#
class RootController < ApplicationController
  #
  def home
    @opts = ORFFinder::DEFAULT_OPTIONS
  end

  def search
    @opts = {}
    params.permit!
    @opts[:sequence] = params['sequence']
    @opts[:start]    = params[:start].to_h.values.reject { |codon| codon.length != 3 }
    @opts[:stop]     = params[:stop].to_h.values.reject { |codon| codon.length != 3 }
    @opts[:reverse]  = params['reverse'] == 'true'
    @opts[:direct]   = params['direct'] == 'true'
    @opts[:min]      = Float(params['min'])
    orf = ORFFinder.new params['sequence'], @opts
    @results = orf.nt
    respond_to do |format|
      format.html { render :home }
    end
  end
end
