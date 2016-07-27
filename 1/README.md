Corporate/Govenrnment Bond Yield Spread Calculator (what a mouthful, eh?)

INSTALLATION:
=============
1. Checkout the code locally
2. cd into folder
3. Run `gem install bundler`
4. Run `bundle install`
5. You're ready, see USAGE: below

USAGE:
======
ruby ./yield_spread.rb bonds

where bonds is an array of hashes, with the following format:
{
  name: 'name of bond'
  type: one of 'government', or 'corporate',
  term: term in years
  yield: yield in percent
}

Please be sure to use single quotes for the strings in the dictionary.

Example:
========
ruby ./yield_spread.rb "[{ name: 'C1', type: 'corporate', term: 10.3, yield: 5.3 }, { name: 'G1', type: 'government', term: 9.4, yield: 3.7 }, { name: 'G2', type: 'government', term: 12, yield: 4.8 }, { name: 'G3', type: 'government', term: 15, yield: 4.8 }]"

Outputs:
bond,benchmark,spread_to_benchmark
C1,G1,1.6%

NOTES:
======
1. I'm using eval in parsing command line arguments. Yes, go ahead, shoot me. I deserve it. Just didn't want to go through setting up OptionParser or Thor, for example, at this point.
