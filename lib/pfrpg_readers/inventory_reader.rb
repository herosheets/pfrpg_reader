class PfrpgReaders::InventoryReader

  attr_reader :inventory, :equipment
  def initialize(character)
    @character = character
    @inventory = get_inventory
    @equipment = get_equipment
  end

  def get_inventory
    @character.inventory
  end

  def get_equipment
    @character.equipment
  end

  def pretty(items)
    items.map { |i| PrettyItem.new(i) }
  end

  def as_json(options={})
    {
      :equipment    => get_equipment,
      :inventory    => get_inventory
    }
  end
end

class PfrpgReaders::PrettyItem
  attr_reader :name, :description, :slot, :type, :equipped

  def initialize(item)
    @name         = item.name
    @description  = item.description
    @slot         = item.slot
    @type         = item.type
  end
end
