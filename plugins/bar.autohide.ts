#!/Users/magtastic/.bun/bin/bun
import { $ } from "bun";
import { sketchybar } from "./lib/sketchybar.ts";

const BAR_HEIGHT = 35;

const getMouseY = async (): Promise<number> => {
  const result = await $`osascript -e 'use framework "AppKit"
set screenFrame to current application'"'"'s NSScreen'"'"'s mainScreen()'"'"'s frame()
set screenH to item 2 of item 2 of screenFrame as integer
set mouseY to (current application'"'"'s NSEvent'"'"'s mouseLocation()'"'"'s y) as integer
return screenH - mouseY'`.text();
  return parseInt(result.trim(), 10);
};

const slideUp = async () => {
  for (let offset = -2; offset >= -BAR_HEIGHT; offset -= 4) {
    sketchybar("--animate", "linear", "4", "--bar", `y_offset=${String(offset)}`);
  }
  await Bun.sleep(150);
  sketchybar("--bar", "hidden=true", "y_offset=0");
};

const slideDown = async () => {
  sketchybar("--bar", "hidden=false", `y_offset=${String(-BAR_HEIGHT)}`);
  for (let offset = -BAR_HEIGHT; offset <= 0; offset += 4) {
    sketchybar("--animate", "linear", "4", "--bar", `y_offset=${String(offset)}`);
  }
};

let barHidden = false;

while (true) {
  const mouseY = await getMouseY();

  if (mouseY <= 5 && !barHidden) {
    await slideUp();
    barHidden = true;
  } else if (mouseY > 30 && barHidden) {
    await slideDown();
    barHidden = false;
  }

  await Bun.sleep(300);
}
