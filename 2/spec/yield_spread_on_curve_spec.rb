require_relative '../yield_spread_on_curve'

describe YieldSpreadOnCurve do
  let(:bond_1) { { name: "C1", type: "corporate", term: 10.3, yield: 5.3 } }
  let(:bond_2) { { name: "C2", type: "corporate", term: 15.2, yield: 8.3 } }
  let(:bond_3) { { name: "G1", type: "government", term: 9.4, yield: 3.7 } }
  let(:bond_4) { { name: "G2", type: "government", term: 12, yield: 4.8 } }
  let(:bond_5) { { name: "G3", type: "government", term: 16.3, yield: 5.5 } }

  describe "calculate" do
    subject { described_class.new(bonds).calculate }

    context "Small Set" do
      let(:bonds) { [bond_1, bond_2, bond_3, bond_4, bond_5] }

      it { expect(subject).to eql ("bond,spread_to_curve\nC1,3.93%\nC2,5.32%") }
    end
  end
end
