# Pulp

**pulp**  */pʌlp/*

*Pulp:*
books and magazines that are of low quality in the way they are produced and the stories and articles they contain

*Synonyms:*
crush, squash, mash, pulverize, triturate

![Pulp](assets/pulp.png "Pulp")

## Description

When [heroku](https://www.heroku.com) decided to stop [offering](https://devcenter.heroku.com/changelog-items/2461) dynos on their free tier I lost my default hosting platform. I had several apps in various states on that tier. Apps that weren't really important enough
for me to pay for on first inspection. However as time has went on I noticed a few that kept creeping up and were a minor pain point for me not having access to. You know the drill.. a lot of minor annoyances make one big one.

Most of my apps were small CRUD apps with the ability to server JSON for other apps to ingest or had a crappy front end. I only paid for one app to move from the free tier, 
however it was costing me over $15 dollars and it wasn't worth it. So I had to find a way of hosting the app in a cost effective way.

So instead of hosting many small apps I've decided to amalgamate the useful ones into one
rails app and host it inside a [droplet](https://www.digitalocean.com/products/droplets) on [Digital Ocean](https://www.digitalocean.com/).

## Hosted Apps

Below is a list of apps I host under pulp. The list will grow larger as I port them over.

- [bookmarks](https://github.com/swmcc/pulp/wiki/Bookmarks)