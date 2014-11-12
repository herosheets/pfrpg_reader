module PfrpgReaders
  class MiscReader
    include PfrpgReaders::FeatureDuplicator
    attr_reader :initiative, :speed, :hit_points, :feats, :class_features, :levels,
                :total_level, :alignment, :languages, :size
    def initialize(character)
      @character      = character
      @initiative     = gen_initiative
      @speed          = gen_speed
      @feats          = gen_feats
      @class_features = gen_class_features
      @levels         = gen_levels
      @total_level    = gen_total_level
      @hit_points     = gen_hit_points
      @alignment      = character.alignment
      @size           = character.racial_size
    end

    def as_json(options={})
      {
        :initiative     => @initiative,
        :alignment      => @alignment,
        :speed          => @speed,
        :hit_points     => @hit_points,
        :feats          => @feats,
        :class_features => @class_features,
        :levels         => @levels,
        :total_level    => @total_level,
        :size           => @size,
        :level_string   => level_string,
        :temporary      => @character.temp_values
      }
    end

    def level_string
      str = "#{alignment} :"
      @levels.each do |l|
        str += "#{l.name}/#{l.level}"
        str += "*" if l.favored
      end
      str
    end

    def gen_hit_points
      hp = @character.hit_points
      # TODO : potentially move off this method when multiple hp affect stats exist
      if (@feats.find { |x| x.name == 'Toughness' })
        hp += 3
        if (total_level > 3)
          hp += total_level - 3
        end
      end
      return hp
    end

    def gen_total_level
      if @character.respond_to? 'get_last_level'
        return 0 if @character.levels.empty?
        return @character.get_last_level.number
      end
      @character.latest_levels.inject(0) {|sum, x| sum = sum + x.class_number }
    end

    def gen_speed
      base_speed =  NullObject.maybe(@character.race).speed || 0
      base_speed += parse_speed_bonuses(@character.get_bonus("speed"))
      base_speed -= @character.armor_speed_penalty
      speeds = {}
      ['land','fly','climb','swim'].each do |type|
        speeds["#{type}_speed"] = calc_speed(type, base_speed)
      end
      speeds['speed'] = speeds['land_speed']
      return speeds
    end

    def calc_speed(speed_type, base)
      base + @character.get_bonus("#{speed_type}_speed")
    end

    def gen_initiative
      initiative = 0
      initiative += @character.dex_mod
      initiative += @character.get_bonus("initiative").to_i
      return initiative
    end

    def gen_feats
      @character.total_feats.map { |x| PrettyFeat.new(x) }
    end

    def gen_class_features
      features = @character.class_features.map { |x| PrettyClassFeature.new(x) }
      filter_duplicates(features)
    end

    def gen_levels
      @character.latest_levels.map { |x| PrettyLevel.new(x, @character) }
    end

    def parse_speed_bonuses(speed_bonuses)
      speed_bonus = 0
      speed_bonuses.each do |s|
        speed_bonus += s.to_i if MathHelper.is_number(s)
      end
      speed_bonus
    end


  end

  class MiscReader::PrettyFeat
    attr_reader :name, :description, :special
    def initialize(char_feat)
      if char_feat.respond_to? 'pathfinder_feat'
        feat = NullObject.maybe(char_feat.pathfinder_feat)
      else
        feat = NullObject.maybe(char_feat.feat)
      end
      @name        = feat.name || "Feat"
      if (@name == 'Custom Feat')
        @description = char_feat.feat_special
      else
        @description = feat.benefit
        @special     = char_feat.feat_special
      end
    end
  end

  class MiscReader::PrettyLevel
    attr_reader :name, :level, :favored
    def initialize(level, character)
      @name     = level.class_name
      @level    = level.class_number
      if character.respond_to? 'preferred_class'
        @favored  = (level.class_name == character.preferred_class)
      end
    end
  end

  class MiscReader::PrettyClassFeature
    attr_reader :name, :description, :type
    def initialize(feature)
      if feature.respond_to? 'feature'
        f = feature.feature
      else
        f = feature
      end
      # TODO this belogns on the feature object
      @type         = feature.feature_type
      @category     = f.category
      @name         = f.display_name
      @description  = f.description
      @special = feature.special
    end
  end
end
