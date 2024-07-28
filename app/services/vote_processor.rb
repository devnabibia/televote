class VoteProcessor
  def initialize(vote_hash)
    @campaign = campaign vote_hash['Campaign']
    @candidate = candidate vote_hash['Choice'].capitalize
  end

  def perform
    @candidate.votes.create
  end

  private

  def campaign(campaign_identifier)
    @campaign = Campaign.find_or_create_by({ identifier: campaign_identifier })
  end

  def candidate(choice)
    @candidate = Candidate.find_or_create_by({ name: choice, campaign: @campaign })
  end
end
