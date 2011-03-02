require File.expand_path("../spec_helper", File.dirname(__FILE__))

# This Spec is to validate the stuff I put in the README
#
describe 'Stubber::Readme' do
  it "shouldn't make me look bad" do
    #
    # str = Lorem::Base.new('paragraphs', 1).output
    #
    str = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat."

    str.stub_words(5).should        == "Lorem ipsum dolor sit amet"
    str.stub_words(5, true).should  == ", consectetuer adipiscing elit. Vivamus vitae"
    str.stub_to(70).should          == "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus "
    str.stub_to(70).size.should     be(66)
    str.stub_thru(70).should        == "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae"
    str.stub_thru(70).size.should   be(71)

    # Now the negatives!
    str.stub_words(-5).should       == "risus vitae lorem iaculis placerat."
    str.stub_words(-5, true).should == "consectetuer adipiscing elit. Vivamus vitae "
    str.stub_to(-45).should         == " vitae risus vitae lorem iaculis placerat."
    str.stub_to(-45).size.should    be(42)
#    str.stub_thru(-50)
  end
end
