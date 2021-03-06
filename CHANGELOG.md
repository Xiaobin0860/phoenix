# Changelog for v1.5

## Phoenix.PubSub 2.0 released

Phoenix.PubSub 2.0 has been released with a more flexible and powerful fastlane mechanism. We use this opportunity to also move Phoenix.PubSub out of the endpoint and explicitly into your supervision tree. To update, you will need to remove or update the `{:phoenix_pubsub, "~> 1.x"}` entry in your `mix.exs` to at least "2.0".

Then once you start an application, you will get a warning about the `:pubsub` key in your endpoint being deprecated. Follow the steps in the warning and you are good to go!

## 1.5.0-dev

### Enhancements

  * [Channel] Do not block the channel supervisor on join
  * [Controller] Support `:disposition` option in `send_download/3`
  * [Controller] Allow filename encoding to be disabled in `send_download/3`
  * [Endpoint] Allow named params to be used when defining socket paths
  * [Generator] Allow a custom migration module to be given to the migration generator
  * [PubSub] Migrate to PubSub 2.0 with a more flexible fastlaning mechanism
  * [Testing] Allow a custom list of headers for recycling to be given to `recycle/2`

### Bug Fixes

### Deprecations

  * [Endpoint] The outdated `Phoenix.Endpoint.CowboyAdapter` for Cowboy 1 is deprecated. Please make sure `{:plug_cowboy, "~> 2.1"}` or later is listed in your `mix.exs`
  * [Endpoint] `subscribe` and `unsubscribe` via the endpoint is deprecated, please use `Phoenix.PubSub` directly instead

### phx.new installer

  * `Phoenix.PubSub` is now started directly in your application supervision tree

### JavaScript client


## v1.4

The CHANGELOG for v1.4 releases can be found [in the v1.4 branch](https://github.com/phoenixframework/phoenix/blob/v1.4/CHANGELOG.md).
