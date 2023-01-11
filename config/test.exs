import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chuck, ChuckWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xVsX9TPjnDh3ewvoQbZmFY2SAfn+S2xjxmy4FYIuAkG0l5GPc3tK6r2lmAIJ+laS",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
