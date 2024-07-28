class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all.filter { |campaign| campaign.votes.count.positive? }
  end

  def show
    @campaign = Campaign.find(params[:id])
  end
end
