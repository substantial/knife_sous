shared_examples_for "a collection object" do
  describe "<<" do
    it "adds objects to the end of the collection" do
      collection << 1 << 2
      collection.to_a.should == [1,2]
    end
  end

  describe "[]" do
    it "gets the object in the collection by its index" do
      collection << 'foo' << 'bar'
      collection[0].should == 'foo'
      collection[1].should == 'bar'
    end
  end

  describe "first" do
    it "gets the first object in the collection" do
      collection << 'bar' << 'baz'
      collection.first.should == 'bar'
    end
  end
end

