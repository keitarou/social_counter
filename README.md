# social_counter

## Install
	gem install social_counter

## Usage Command Line

	social_counter -u [page url]

## Usage Ruby Program
	require 'social_counter'

	@sc = SocialCounter.new('http://google.com')
	p @sc.title
	p @sc.twitter_count
	p @sc.facebook_count
	p @sc.hatena_count

## Support Social Services
- Twitter
- Facebook
- Hatena Bookmark
- Google Plus
- Pocket
- Linkedin
- Delicious
- Pinterest
- Reddit

## Copyright
Copyright (c) 2013 keitarou.oonishi. See LICENSE.txt for
further details.

