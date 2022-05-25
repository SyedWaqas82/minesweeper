class BoardValidator < ActiveModel::Validator
  def validate(record)
    if record.nil?
      record.errors[:base] << "The object can't be null"
    elsif not record.height.is_a?(Integer) or not record.width.is_a?(Integer)
      record.errors[:base] << "Width and height must be numbers"
    elsif record.height <= 0 or record.width <= 0
      record.errors[:base] << "Width and height must be positive integers"
    elsif not record.bombs_count.is_a?(Integer)
      record.errors[:base] << "Number of bombs must be a number"
    elsif record.bombs_count <= 0
      record.errors[:base] << "Number of bombs must be greater than zero"
    else
      cells_count = record.width * record.height
      if record.bombs_count >= cells_count
        record.errors[:base] << "Number of bombs must be less than the number of cells"
      end
    end
  end
end