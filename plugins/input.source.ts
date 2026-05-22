#!/usr/bin/env bun
import { $ } from "bun";
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = env("NAME");

// AppleSelectedInputSourcesChangedNotification fires before the prefs daemon
// finishes propagating the new value, so reading immediately returns the old
// layout. A small delay lets cfprefsd catch up.
await Bun.sleep(150);

const sourceId = (
  await $`defaults read com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID`
    .quiet()
    .nothrow()
    .text()
).trim();

// e.g. "com.apple.keylayout.Icelandic" -> "Icelandic"
const layout = sourceId.split(".").pop() ?? "";
const label = layout === "Icelandic" ? "ÍS" : "EN";

sketchybar("--set", NAME, `label=${label}`);
