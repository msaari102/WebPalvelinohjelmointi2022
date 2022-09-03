irb(main):001:0> b = Brewery.new name: "BrewDog", year: 2007
=> #<Brewery:0x00007f18cdc154c0 id: nil, name: "BrewDog", year: 2007, created_at: nil, updated_at: nil>
irb(main):002:0> b.save
  TRANSACTION (0.1ms)  begin transaction
  Brewery Create (0.8ms)  INSERT INTO "breweries" ("name", "year", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "BrewDog"], ["year", 2007], ["created_at", "2022-08-28 10:49:03.485678"], ["updated_at", "2022-08-28 10:49:03.485678"]]
  TRANSACTION (1.3ms)  commit transaction
=> true
irb(main):003:0> Beer.create name: "Punk IPA", style: "IPA", brewery_id: b.id
  TRANSACTION (0.0ms)  begin transaction
  Brewery Load (0.2ms)  SELECT "breweries".* FROM "breweries" WHERE "breweries"."id" = ? LIMIT ?  [["id", 5], ["LIMIT", 1]]
  Beer Create (0.5ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Punk IPA"], ["style", "IPA"], ["brewery_id", 5], ["created_at", "2022-08-28 10:49:51.235411"], ["updated_at", "2022-08-28 10:49:51.235411"]]
  TRANSACTION (1.4ms)  commit transaction
=>
#<Beer:0x00007f18cc756340
 id: 15,
 name: "Punk IPA",
 style: "IPA",
 brewery_id: 5,
 created_at: Sun, 28 Aug 2022 10:49:32.972607000 UTC +00:00,
 updated_at: Sun, 28 Aug 2022 10:49:32.972607000 UTC +00:00>
irb(main):004:0> Beer.create name: "Nanny State", style: "lowalcohol", brewery_id: b.id
  TRANSACTION (0.0ms)  begin transaction
  Brewery Load (0.2ms)  SELECT "breweries".* FROM "breweries" WHERE "breweries"."id" = ? LIMIT ?  [["id", 5], ["LIMIT", 1]]
  Beer Create (0.5ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Nanny State"], ["style", "lowalcohol"], ["brewery_id", 5], ["created_at", "2022-08-28 10:50:07.235089"], ["updated_at", "2022-08-28 10:50:07.235089"]]
  TRANSACTION (1.4ms)  commit transaction
=>
#<Beer:0x00007f18cc496e20
 id: 16,
 name: "Nanny State",
 style: "lowalcohol",
 brewery_id: 5,
 created_at: Sun, 28 Aug 2022 10:50:07.235089000 UTC +00:00,
 updated_at: Sun, 28 Aug 2022 10:50:07.235089000 UTC +00:00>
 irb(main):013:0> b = Beer.find 14
  Beer Load (0.3ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 15], ["LIMIT", 1]]
=>
#<Beer:0x00007f18cd6f57b0
irb(main):014:0> b.ratings.create score: 5
  TRANSACTION (0.0ms)  begin transaction
  Rating Create (0.8ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 5], ["beer_id", 15], ["created_at", "2022-08-28 11:02:52.026719"], ["updated_at", "2022-08-28 11:02:52.026719"]]
  TRANSACTION (1.6ms)  commit transaction
=> #<Rating:0x00007f18ce3873e8 id: 4, score: 5, beer_id: 14, created_at: Sun, 28 Aug 2022 11:02:52.026719000 UTC +00:00, updated_at: Sun, 28 Aug 2022 11:02:52.026719000 UTC +00:00>
irb(main):016:0> b.ratings.create score: 16
  TRANSACTION (0.0ms)  begin transaction
  Rating Create (0.7ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 16], ["beer_id", 15], ["created_at", "2022-08-28 11:03:34.303752"], ["updated_at", "2022-08-28 11:03:34.303752"]]
  TRANSACTION (1.6ms)  commit transaction
=> #<Rating:0x00007f18cf376dd0 id: 5, score: 16, beer_id: 15, created_at: Sun, 28 Aug 2022 11:03:34.303752000 UTC +00:00, updated_at: Sun, 28 Aug 2022 11:03:34.303752000 UTC +00:00>
irb(main):017:0> b.ratings.create score: 12
  TRANSACTION (0.1ms)  begin transaction
  Rating Create (0.9ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 12], ["beer_id", 15], ["created_at", "2022-08-28 11:04:23.680992"], ["updated_at", "2022-08-28 11:04:23.680992"]]
  TRANSACTION (2.9ms)  commit transaction
=> #<Rating:0x00007f18cc954fc0 id: 6, score: 12, beer_id: 15, created_at: Sun, 28 Aug 2022 11:04:23.680992000 UTC +00:00, updated_at: Sun, 28 Aug 2022 11:04:23.680992000 UTC +00:00>
irb(main):018:0> b = Beer.find 16
  Beer Load (0.2ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 16], ["LIMIT", 1]]
=>
#<Beer:0x00007f18cc4e4bc0
...
irb(main):019:0> b.ratings.create score: 22
  TRANSACTION (0.0ms)  begin transaction
  Rating Create (0.8ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 22], ["beer_id", 16], ["created_at", "2022-08-28 11:05:13.503413"], ["updated_at", "2022-08-28 11:05:13.503413"]]
  TRANSACTION (1.7ms)  commit transaction
=> #<Rating:0x00007f18cc0a5938 id: 7, score: 22, beer_id: 16, created_at: Sun, 28 Aug 2022 11:05:13.503413000 UTC +00:00, updated_at: Sun, 28 Aug 2022 11:05:13.503413000 UTC +00:00>
irb(main):020:0> b.ratings.create score: 18
  TRANSACTION (0.0ms)  begin transaction
  Rating Create (0.6ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 18], ["beer_id", 16], ["created_at", "2022-08-28 11:05:23.086760"], ["updated_at", "2022-08-28 11:05:23.086760"]]
  TRANSACTION (1.6ms)  commit transaction
=> #<Rating:0x00007f18cdb54ba8 id: 8, score: 18, beer_id: 16, created_at: Sun, 28 Aug 2022 11:05:23.086760000 UTC +00:00, updated_at: Sun, 28 Aug 2022 11:05:23.086760000 UTC +00:00>
irb(main):021:0> b.ratings.create score: 33
  TRANSACTION (0.0ms)  begin transaction
  Rating Create (0.7ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 33], ["beer_id", 16], ["created_at", "2022-08-28 11:05:28.878922"], ["updated_at", "2022-08-28 11:05:28.878922"]]
  TRANSACTION (1.6ms)  commit transaction
=> #<Rating:0x00007f18cd675fb0 id: 9, score: 33, beer_id: 16, created_at: Sun, 28 Aug 2022 11:05:28.878922000 UTC +00:00, updated_at: Sun, 28 Aug 2022 11:05:28.878922000 UTC +00:00>