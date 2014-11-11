class PfrpgReaders::SavesReader
  attr_reader :character, :con_modifier, :dex_modifier, :wis_modifier,
              :saves, :bonuses
  def initialize(character)
    @character    = character
    @con_modifier = character.con_mod
    @wis_modifier = character.wis_mod
    @dex_modifier = character.dex_mod
    @saves        = character.get_saves
    @bonuses      = character.get_save_bonuses
  end

  def as_json(options={})
    {
      :con_modifier => @con_modifier,
      :wis_modifier => @wis_modifier,
      :dex_modifier => @dex_modifier,
      :base_ref     => @saves[:ref],
      :base_fort    => @saves[:fort],
      :base_will    => @saves[:will],
      :bonus_ref    => @bonuses[:ref],
      :bonus_will   => @bonuses[:will],
      :bonus_fort   => @bonuses[:fort],
      :fortitude    => fortitude,
      :reflex       => reflex,
      :will         => will
    }
  end

  def fortitude
    con_modifier + saves[:fort] + bonuses[:fort]
  end

  def reflex
    dex_modifier + saves[:ref] + bonuses[:ref]
  end

  def will
    wis_modifier + saves[:will] + bonuses[:will]
  end
end

