help:
	@echo "Make targets:"
	@echo
	@echo "server - start the server"
	@echo "iex-server - start the server with the interactive shell"
	@echo "reset-db - reinitialize the database"
	@echo "test - run the unit tests"

.env:
	@echo "Please create a '.env' file first. Copy 'dev.env' to '.env' for a start."
	@exit 1

server: .env
	source .env && \
	mix phx.server

iex:
	make iex-server

iex-server: .env
	source .env && \
	iex -S mix phx.server

mix:
	iex -S mix

reset-db: .env
	source .env && \
	make rebuild-db

rebuild-db:
	mix ecto.drop && \
	mix ecto.create && \
	mix ecto.migrate && \
	mix run priv/repo/seeds.exs

test: .env
	source .env && \
	    MIX_ENV=test mix test

.PHONY: test rebuild-db reset-db mix iex-server server help
