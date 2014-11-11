module PfrpgReaders
  class ValidationReader
    attr_reader :feats, :skills, :features
    def initialize(entity)
      @entity = entity
      @feats = feat_total
      @skills = skill_total
      @features = feature_total
    end

    def feat_total
      return PfrpgTables::FeatTotaler.new(entity).total
    end

    def skill_total
      0
    end

    def feature_total
      0
    end

    def as_json(options = {})
      {
        :feats => @feats,
        :skills => @skills,
        :features => @features
      }
    end

  end
end
