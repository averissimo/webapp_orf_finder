require 'orf_finder'

class RootController < ApplicationController

  def home
    @opts = ORFFinder::DEFAULT_OPTIONS
  end

  def search
    byebug
  end
end
