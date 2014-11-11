module PfrpgReaders
  module PfrpgReaders
    class PfrpgNpc
      attr_reader :npc, :attributes, :feats, :skills, :spells, :combat, :misc,
                  :inventory, :avatar

      def initialize(npc)
        @npc    = npc
        @attributes   = AttributesReader.new(npc)
        @demographics = DemographicsReader.new(npc)
        @combat       = CombatReader.new(npc)
        @saves        = SavesReader.new(npc)
        @misc         = MiscReader.new(npc)
        @skills       = SkillsReader.new(npc)
        @inventory    = InventoryReader.new(npc)
        @spells       = SpellsReader.new(npc)
        @validation   = ValidationReader.new(npc)
        @avatar       = npc.avatar
      end

      def as_json(options={})
        {
          :id         => @npc.id,
          :uuid       => @npc.uuid,
          :npc        => @npc,
          :demographics => @demographics,
          :attributes => @attributes,
          :combat     => @combat,
          :saves      => @saves,
          :misc       => @misc,
          :skills     => @skills,
          :spells     => @spells,
          :inventory  => @inventory,
          :validation => @validation,
          :avatar     => AvatarURL.new(@avatar)
        }
      end
    end
  end
end
