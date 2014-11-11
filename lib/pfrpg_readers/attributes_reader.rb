class PfrpgReaders::AttributesReader
  attr_reader :character

  def initialize(character)
    @character = character
  end

  def as_json(options={})
    {
      :values => {
        :strength => strength,
        :dexterity => dexterity,
        :charisma => charisma,
        :wisdom => wisdom,
        :constitution => constitution,
        :intelligence => intelligence
      },
      :modifier => {
        :strength => strength_modifier,
        :dexterity => dexterity_modifier,
        :charisma => charisma_modifier,
        :wisdom => wisdom_modifier,
        :constitution => constitution_modifier,
        :intelligence => intelligence_modifier
      }
    }
  end

  def strength
    @character.modified_str
  end

  def strength_modifier
    @character.str_mod
  end

  def dexterity
    @character.modified_dex
  end

  def dexterity_modifier
   @character.dex_mod
  end

  def charisma
    @character.modified_cha
  end

  def charisma_modifier
    @character.cha_mod
  end

  def intelligence
    @character.modified_int
  end

  def intelligence_modifier
    @character.int_mod
  end

  def wisdom
    @character.modified_wis
  end

  def wisdom_modifier
    @character.wis_mod
  end

  def constitution
    @character.modified_con
  end

  def constitution_modifier
    @character.con_mod
  end
end
