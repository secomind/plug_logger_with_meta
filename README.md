# PlugMetadataLogger

PlugMetadataLogger is a [Plug.Logger](https://hexdocs.pm/plug/Plug.Logger.html) based on Plug.Logger code, focused on metadata logging.

## Why
Plug.Logger does not use [Logger.metadata](https://hexdocs.pm/logger/Logger.html#metadata/1),
so some useful information such as `method` and `request_path` are embedded into the log message
hence they must be scraped.

PlugMetadataLogger makes them machine readable by exporting them using Logger.metadata.

## Installation
- Add `:plug_metadata_logger` dependency to your project's `mix.exs`:

```elixir
def deps do
  [
    {:plug_metadata_logger, "~> 0.1"}
  ]
end
```
- Run `mix deps.get`

- Replace `Plug.Logger` with `PlugMetadataLogger`:

```diff
--- a/endpoint.ex
+++ b/endpoint.ex
@@ -38,7 +38,7 @@ defmodule MyProject.APIWeb.Endpoint do
   end
 
   plug Plug.RequestId
-  plug Plug.Logger
+  plug PlugMetadataLogger
```

- Add relevant metadata to your logger configuration:

```elixir
 config :logger, :console, format: "[$level] $message\n"
+  metadata: [
+    :method,
+    :request_path,
+    :status_code,
+    :elapsed,
+  ]
```

- Optional: use it with [pretty_log](https://github.com/ispirata/pretty_log) (or any other logger formatter/backend)

`pretty_log` will format all metadata using logfmt.

## Available Metadata

- elapsed (e.g. `22ms`)
- method (e.g. `GET`)
- request_path (e.g. `/v1/my/path`)
- status_code (e.g. `200`)
- tag (e.g. `got_client_req`, `sent_reply`)

## About This Project

This project has been created in order to provide better logs in [Astarte](https://github.com/astarte-platform/astarte).
We are open to any contribution and we encourage adoption of this library, also outside Astarte, in order to provide better logs to everyone.
