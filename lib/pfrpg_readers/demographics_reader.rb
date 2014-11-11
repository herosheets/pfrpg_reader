class PfrpgReaders::DemographicsReader
  attr_reader :player_name, :character_name, :deity, :gender

  def initialize(character)
    if @character.respond_to? 'player_name'
      @player_name    = character.player_name
    end
    @character_name = character.name
    @deity          = character.deity
    @gender         = character.gender
  end

  def as_json(options={})
    {
      :player_name    => @player_name,
      :character_name => @character_name,
      :deity          => @deity,
      :gender         => @gender
    }
  end
end
