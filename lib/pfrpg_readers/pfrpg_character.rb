module PfrpgReaders
  class PFRPGCharacter
    attr_reader :character, :attributes, :feats, :skills, :spells, :combat, :misc,
                :inventory, :avatar

    def initialize(character)
      @character    = character
      @attributes   = AttributesReader.new(character)
      @demographics = DemographicsReader.new(character)
      @combat       = CombatReader.new(character)
      @saves        = SavesReader.new(character)
      @misc         = MiscReader.new(character)
      @skills       = SkillsReader.new(character)
      @inventory    = InventoryReader.new(character)
      @spells       = SpellsReader.new(character)
      @avatar       = character.avatar if character.respond_to? 'avatar'
    end

    def as_json(options={})
     p = {
        :id         => @character.id,
        :uuid         => @character.uuid,
        :character  => @character,
        :demographics => @demographics,
        :attributes => @attributes,
        :combat     => @combat,
        :saves      => @saves,
        :misc       => @misc,
        :skills     => @skills,
        :spells     => @spells,
        :inventory  => @inventory
      }
      p[:avatar] = AvatarURL.new(@avatar) if @avatar
      p
    end

    def find_by_id(id)
      Character.find(id)
    end
  end
end
