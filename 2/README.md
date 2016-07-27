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
ruby ./yield_spread_on_curve.rb bonds

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
ruby ./yield_spread_on_curve.rb "[{ name: 'C1', type: 'corporate', term: 10.3, yield: 5.3 }, { name: 'C2', type: 'corporate', term: 15.2, yield: 8.3 }, { name: 'G1', type: 'government', term: 9.4, yield: 3.7 }, { name: 'G2', type: 'government', term: 12, yield: 4.8 }, { name: 'G3', type: 'government', term: 16.3, yield: 5.5 }]"

Outputs:
bond,spread_to_curve
C1,3.93%
C2,5.32%

NOTES:
======
1. The results that I get when runnning the example above is different than the supplied ones. I believe that mine are correct because it makes sense for the resulting yield to fall within the confines of the "enveloping" government bonds' yields.
