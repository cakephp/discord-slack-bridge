# discord-slack-bridge

An ill-named internal discord &lt;=> rocketchat &lt;=> slack chat bridge

## Bridges

- #dev: the core dev chatroom
  - slack (#dev): enabled
  - discord (#dev): enabled
- #internal: a chatter room for core dev and cakedc folks to coordinate on cakesf-related tasks (such as cakefest or the websites)
  - discord (#internal): enabled
  - slack (#internal): enabled
  - rocketchat (#cakephp): enabled (cakedc only)
- #support: a mirror for the official support channel
  - discord (#support): enabled
  - slack (#support): enabled

## Adding a new bridge

- Add the `redvelvet` app on slack to the channel.
- Create a new webhook integration for the discord channel (remember to save the integrations!) and copy the webhook.
- Add a new stanza like so to the `matterbridge.toml.sigl`:
    ```
    [[gateway]]
    name   = "$CHANNEL_ALIAS"
    enable = true

    [[gateway.inout]]
    account = "discord.dev"
    channel = "$DISCORD_CHANNEL_NAME_WITHOUT_HASH"

    [[gateway.inout]]
    account = "slack.dev"
    channel = "$SLACK_CHANNEL_NAME_WITHOUT_HASH"
    ```
- In the previously added `gateway` stanza, ensure the following are changed (using `#lollipop` as the example channel name on both discord and slack):
    - `$CHANNEL_ALIAS`: should be `lollipop`
    - `$DISCORD_CHANNEL_NAME_WITHOUT_HASH`: should be `lollipop`
    - `$SLACK_CHANNEL_NAME_WITHOUT_HASH`: should be `lollipop`
- Deploy with the new bridge settings.
