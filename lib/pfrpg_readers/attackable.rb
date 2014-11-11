require_relative 'filters/filter.rb'

module PfrpgReaders
  module Attackable
    def combat_maneuver_bonus
      base = str_bonus + bab - size_modifier
      misc = character.get_bonus('cmb').to_i
      base += misc
      return base
    end

    def attack_filters
      standard_filters = [
        Filters::StrengthMod.new(character),
        Filters::WeaponFinesseMod.new(character),
        Filters::RangedAttackMod.new(character),
        Filters::WeaponFocusMod.new(character),
        Filters::WeaponSpecializationMod.new(character),
        Filters::ProficiencyMod.new(character)
      ]
      standard_filters << character.get_attack_filters
      standard_filters.flatten
    end

    def attacks
      atk = []
      character.equipped_weapons.each do |w|
        atk << Attack.new({    :weapon_name =>  w.get_best_name,
                               :range        => w.range,
                               :weight_class => w.weight_class,
                               :damage       => w.damage,
                               :weapon_type  => w.weapon_type,
                               :critical_range => w.critical_range,
                               :critical_dmg => w.critical_dmg,
                               :bonus        => w.bonus,
                               :strength_bonus   => str_bonus,
                               :bab          => bab,
                               :size         => character.race.size,
                               :filters      => attack_filters,
                               :filter_str   => [],
                               :weapon       => w
                       })
      end
      return atk
    end
  end
end
