require 'orf_finder'

#
class RootController < ApplicationController
  #
  def home
    @opts = ORFFinder::DEFAULT_OPTIONS

    if @opts[:sequence].nil? || @opts[:sequence].length == 0
      @opts[:sequence] = <<-EOF
>sample example (this line is optional and does nothing)
aaaatgaaaaaatgaaaataaataaataa
aatgaaaaaaaaaaaaaaaaaaaaatga
EOF
    end

    save_request_info
  end

  def search
    @opts = {}
    params.permit!
    @opts[:sequence] = params['sequence']
    @opts[:start]    = params[:start].to_h.values
                       .reject { |codon| codon.length != 3 }
                       .collect(&:downcase)
    @opts[:stop]     = params[:stop].to_h.values
                       .reject { |codon| codon.length != 3 }
                       .collect(&:downcase)
    @opts[:reverse]  = params['reverse'] == 'true'
    @opts[:direct]   = params['direct'] == 'true'
    @opts[:min]      = Float(params['min'])
    #
    @opts[:sequence] = @opts[:sequence]
    #
    orf = ORFFinder.new @opts[:sequence].downcase.gsub(/(^>.*)|\n/, ''), @opts
    @results = orf.nt

    save_request_info(@opts)

    respond_to do |format|
      format.html { render :home }
      format.js {}
    end
  end

  private

  def save_request_info(options = nil)
    u = Usage.new(
      ip:     request.ip,
      method: request.method,
      agent:  request.user_agent,
      url:    request.fullpath
    )

    unless options.nil?
      u.sequence     = options[:sequence]
      u.start_codons = options[:start].join ', '
      u.stop_codons  = options[:stop]. join ', '
      u.direct       = options[:direct]
      u.reverse      = options[:reverse]
      u.min          = options[:min]
    end
    u.save
  end
end
