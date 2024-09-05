require_relative '../lib/player_ttt'

describe PlayerTTT do
  context 'when player is X' do
    subject(:player_x) { described_class.new('X') }
    let(:table_x) { double('table_ttt') }

    context 'and there is a row of X on the table' do
      before do
        player_x.instance_variable_set(:@table, table_x)
        allow(table_x).to receive(:mark_x).and_return([1, 2, 3, 4, 5, 7, 9])
      end

      it 'declares that X won' do
        expect(player_x).to be_win
      end
    end

    context 'and there is a column of X on the table' do
      before do
        player_x.instance_variable_set(:@table, table_x)
        allow(table_x).to receive(:mark_x).and_return([3, 5, 6, 8, 9])
      end

      it 'declares that X won' do
        expect(player_x).to be_win
      end
    end

    context 'and there is a diagonal of X on the table' do
      before do
        player_x.instance_variable_set(:@table, table_x)
        allow(table_x).to receive(:mark_x).and_return([2, 3, 5, 6, 7, 8])
      end

      it 'declares that X won' do
        expect(player_x).to be_win
      end
    end

    context 'and there is neither a row, column nor diagonal of X on the table' do
      before do
        player_x.instance_variable_set(:@table, table_x)
        allow(table_x).to receive(:mark_x).and_return([3, 4, 5, 8, 9])
      end

      it 'declares that X has not yet won' do
        expect(player_x).not_to be_win
      end
    end
  end
end
