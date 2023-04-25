CURRENT_BRANCH := `git branch --show-current`

branch:
	echo $(CURRENT_BRANCH)

local.run:
	./bin/dev 

local.setup:
	bundle install 

local.tests:
	rspec

production.console:

production.db.shell:

production.db.migrate:

production.setup:

production.deploy:

production.logs:

