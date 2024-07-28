namespace :votes do
  desc 'imports campaigns, candidates and votes from log file'
  task import_votes: [:environment] do
    file_path = ENV['file_path']
    pattern = /
    ^VOTE\s\d+\s              # VOTE + space + digits + space
    Campaign:\S+\s            # Campaign: + non-whitespace chars + space
    Validity:during\s         # Validity:during + space
    Choice:\S+\s              # Choice: + non-whitespace chars + space
    CONN:\S+\s                # CONN: + non-whitespace chars + space
    MSISDN:\S+\s              # MSISDN: + non-whitespace chars + space
    GUID:\S+\s                # GUID: + non-whitespace chars + space
    Shortcode:\d+             # Shortcode: + digits
    $/x

    unless File.exist?(file_path)
      puts 'Incorrect filepath. Please check the file you are referring to exists.'
      return
    end

    puts 'Processing votes...'
    valid_votes = 0
    invalid_votes = 0

    File.readlines(file_path).each do |line|
      split_vote = line.split(' ')[2...]
      vote_hash = Hash[split_vote.map { |attr| attr.split ':' }]

      if line =~ pattern
        VoteProcessor.new(vote_hash).perform
        valid_votes += 1
        puts "#{valid_votes} valid votes counted"
      else
        campaign = Campaign.find_or_create_by({ identifier: vote_hash['Campaign'] })
        campaign&.update({ vote_errors: campaign.vote_errors + 1 })
        invalid_votes += 1
      end
    end

    total_votes = valid_votes + invalid_votes
    puts 'Processing complete.'
    puts "#{total_votes} votes counted of which #{valid_votes} were valid, and #{invalid_votes} were invalid."
  end
end
