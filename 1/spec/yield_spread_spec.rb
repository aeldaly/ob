require_relative '../yield_spread'

describe YieldSpread do
  let(:bond_1) { { name: "C1", type: "corporate", term: 10.3, yield: 5.3 } }
  let(:bond_2) { { name: "G1", type: "government", term: 9.4, yield: 3.7 } }
  let(:bond_3) { { name: "G2", type: "government", term: 12, yield: 4.8 } }
  let(:bond_4) { { name: "G3", type: "government", term: 15, yield: 4.8 } }

  describe "calculate" do
    subject { described_class.new(bonds).calculate }

    context "2 bonds - A" do
      let(:bonds) { [bond_1, bond_3] }

      it { expect(subject).to eql ("bond,benchmark,spread_to_benchmark\nG2,C1,-0.5%") }
    end

    context "2 bonds - B" do
      let(:bonds) { [bond_1, bond_2] }

      it { expect(subject).to eql ("bond,benchmark,spread_to_benchmark\nC1,G1,1.6%") }
    end

    context "3 bonds" do
      let(:bonds) { [bond_1, bond_2, bond_3] }

      it { expect(subject).to eql ("bond,benchmark,spread_to_benchmark\nC1,G1,1.6%") }
    end

    context "3 bonds" do
      let(:bonds) { [bond_1, bond_3, bond_2] }

      it { expect(subject).to eql ("bond,benchmark,spread_to_benchmark\nC1,G1,1.6%") }
    end

    context "3 bonds" do
      let(:bonds) { [bond_2, bond_1, bond_3] }

      it { expect(subject).to eql ("bond,benchmark,spread_to_benchmark\nC1,G1,1.6%") }
    end

    context "3 bonds" do
      let(:bonds) { [bond_2, bond_3, bond_1] }

      it { expect(subject).to eql ("bond,benchmark,spread_to_benchmark\nC1,G1,1.6%") }
    end

    context "3 bonds" do
      let(:bonds) { [bond_3, bond_1, bond_2] }

      it { expect(subject).to eql ("bond,benchmark,spread_to_benchmark\nC1,G1,1.6%") }
    end

    context "3 bonds" do
      let(:bonds) { [bond_3, bond_2, bond_1] }

      it { expect(subject).to eql ("bond,benchmark,spread_to_benchmark\nC1,G1,1.6%") }
    end

    context "4 bonds" do
      let(:bonds) { [bond_3, bond_4, bond_2, bond_1] }

      it { expect(subject).to eql ("bond,benchmark,spread_to_benchmark\nC1,G1,1.6%") }
    end
  end
end
