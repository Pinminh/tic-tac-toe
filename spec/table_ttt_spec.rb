require_relative '../lib/table_ttt'

describe TableTTT do
  subject(:table) { described_class.new }

  describe '#add_mark' do
    it 'returns true when position and mark type are valid' do
      expect(table.add_mark(5, 'O')).to eq true
    end

    it 'raises error when mark type is neither X nor O' do
      expect { table.add_mark(4, '@c') }.to raise_error('invalid mark type')
    end

    it 'raises error when mark type is x or o since it is case-sensitive' do
      expect { table.add_mark(3, 'x') }.to raise_error('invalid mark type')
    end

    it 'raises error when position is above 9' do
      expect { table.add_mark(10, 'O') }.to raise_error('invalid position')
    end

    it 'raises error when position is below 1' do
      expect { table.add_mark(0, 'X') }.to raise_error('invalid position')
    end

    it 'raises mark type error when both position and mark type are invalid' do
      expect { table.add_mark(-1, 'a') }.to raise_error('invalid mark type')
    end

    it 'changes the slot at input position from number to input mark type' do
      expect { table.add_mark(8, 'X') }
        .to change { table.instance_variable_get(:@table) }
        .from([1, 2, 3, 4, 5, 6, 7, 8, 9])
        .to([1, 2, 3, 4, 5, 6, 7, 'X', 9])
    end

    it 'updates the set of X positions when an X is marked' do
      expect { table.add_mark(2, 'X') }
        .to change { table.mark_x }
        .from([]).to([2])
    end
  end

  describe '#occupied?' do
    let(:played_table) { ['X', 'X', 'O', 4, 'X', 6, 7, 'O', 9] }

    before do
      table.instance_variable_set(:@table, played_table)
    end

    it 'returns true when there is an X or O at given position' do
      expect(table.occupied?(2)).to eq true
    end

    it 'returns false when there is neither an X nor O at given position' do
      expect(table.occupied?(4)).to eq false
    end

    it 'returns false when the position is not valid' do
      expect(table.occupied?(100)).to eq false
    end
  end
end
