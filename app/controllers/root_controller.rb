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

    @opts[:codon_table] = ORF::DEFAULT_CODON_TABLE if @opts[:codon_table].nil?
    @opts[:same_as_codon_table] = false if @opts[:same_as_codon_table].nil?

    save_request_info
  end

  def search
    @opts = {}
    params.permit!
    @opts[:sequence] = params['sequence']
    #
    @opts[:reverse]  = params['reverse'] == 'true'
    @opts[:direct]   = params['direct'] == 'true'
    @opts[:min]      = Float(params['min'])
    #
    @opts[:sequence] = @opts[:sequence]
    #
    @opts[:codon_table] = if params['codon_table'].nil?
                            ORF::DEFAULT_CODON_TABLE
                          else
                            Integer(params['codon_table'])
                          end
    #
    @opts[:same_as_codon_table] = params['same_as_codon_table'] == 'true'
    if @opts[:same_as_codon_table]
      @opts[:start] = Bio::CodonTable[@opts[:codon_table]].start
      @opts[:stop] = Bio::CodonTable[@opts[:codon_table]].stop
    else
      #
      @opts[:start]    = params[:start].to_h.values
                         .reject { |codon| codon.length != 3 }
                         .collect(&:downcase)
      @opts[:stop]     = params[:stop].to_h.values
                         .reject { |codon| codon.length != 3 }
                         .collect(&:downcase)
    end
    #
    orf = ORFFinder.new @opts[:sequence].downcase.gsub(/(^>.*)|\n|\r/, ''),
                        @opts[:codon_table],
                        @opts
    @results    = orf.nt
    @results_aa = orf.aa

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
