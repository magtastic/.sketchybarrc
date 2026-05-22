#!/usr/bin/env bun
import { $ } from "bun";
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = env("NAME");
const output = await $`ifconfig en0`.text();
const active = output.includes("status: active");

sketchybar("-m", "--set", NAME, `drawing=${active ? "on" : "off"}`);
