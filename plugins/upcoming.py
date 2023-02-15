#!/usr/bin/env python3

import os, subprocess, re, datetime, json, hashlib

class Event:
    def __init__(self, uid, title, diff, ongoing, time, url, calendar):
        self.uid = uid
        self.title = title
        self.title_cut = self.title[:100].strip()
        self.diff = diff
        self.human_diff = ':'.join(str(self.diff).split(':')[:-1])
        self.ongoing = ongoing
        self.time = time
        self.url = url
        if self.ongoing:
            self.human_str = f"{self.title_cut} {self.human_diff} left"
        else:
            self.human_str = f"{self.title_cut} in {self.human_diff}"
        self.calendar = '0xffbb99ff'

        if (calendar == 'Diego Pereira'):
            self.calendar = '0xdb4a90e2'
        elif (calendar == 'paulaseila@gmail.com'):
            self.calendar = '0xffec6d6d'

    def __repr__(self):
        return f"Event(uid: {self.uid}, title: {self.title}, diff: {self.diff}, ongoing: {self.ongoing}, time: {self.time}, url: {self.url}, calendar: {self.calendar})"

def get_events():
    datetime_format = '%d %b %Y %H:%M'
    now = datetime.datetime.now()
    url_pattern = r'\b((?:https?://)?(?:(?:www\.)?(?:[\da-z\.-]+)\.(?:[a-z]{2,6})|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:(?:[0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?:(?::[0-9a-fA-F]{1,4}){1,6})|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(?:ffff(?::0{1,4}){0,1}:){0,1}(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])))(?::[0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])?(?:/[\w\.-]*)*/?)\b'

    cmd = "icalBuddy -n -nrd -npn -ea -ps '/🛂/' -nnr ' ' -b '' -ab '' -iep 'title,notes,datetime' -uid eventsToday+1"
    output = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
    lines = output.decode('utf-8').strip().split('\n')

    events = []
    if lines == ['']: return events

    for line in lines:
        splat = line.split('🛂')

        match = re.search('^(.*?) \((.*?)\)$', splat[0])

        title = match.group(1)
        calendar = match.group(2)

        urlsfound = re.findall(url_pattern, splat[1])

        meetingurls = ['teams.microsoft.com', 'us02web.zoom.us', 'meet.google.com']
        urls = []
        for url in urlsfound:
            for meetingurl in meetingurls:
                if meetingurl in url:
                    urls.append(url)

        url = (urls + [None])[0]

        uid = splat[-1].encode('utf-8')

        timerange = splat[-2].replace('at ', '')
        starttime, endtime = timerange.split(' - ')

        endtime = datetime.datetime.strptime(starttime[:-5] + endtime, datetime_format)
        starttime = datetime.datetime.strptime(starttime, datetime_format)

        ongoing = starttime <= now <= endtime
        if ongoing:
            diff = endtime-now
        else:
            diff = starttime-now

        time = ' '.join(timerange.split()[3:])

        uid = hashlib.md5(f'{uid} {time}'.encode('utf-8')).hexdigest()

        events.append(Event(uid, title, diff, ongoing, time, url, calendar))
    return events

def generate_main_text(events):
    next_event_text = ' > ' + events[1].human_str if (len(events) > 1 and events[0].ongoing) else ''
    return events[0].human_str + next_event_text

def plugin_undraw():
    args = [
        '--set upcoming drawing=off',
    ]
    os.system('sketchybar -m ' + ' '.join(args))

def plugin_draw(main_text, popup_items):
    args = [
        f'--set upcoming label="{main_text}"',
        '--set upcoming drawing=on',
    ]

    events_drawed = get_drawed_events()

    if events_drawed is None:
        events_drawed = []
    
    for item in popup_items:
        name = f'upcoming.{item["uid"]}'

        if name in events_drawed:
            args += [
                f'--set {name} label="{item["text"]}"',
                f'--set {name} click_script="open {item["url"]} ; sketchybar -m --set upcoming popup.drawing=off"'
            ]
            continue

        args += [
            f'--add item {name} popup.upcoming',
            f'--set {name} icon=􀑌',
            f'--set {name} icon.padding_left=0',
            f'--set {name} icon.padding_right=4',
            f'--set {name} icon.color={item["calendar"]}',
            f'--set {name} label.color=0xff7d7865',
            f'--set {name} background.padding_left=6',
            f'--set {name} background.padding_right=6',
            f'--set {name} label="{item["text"]}"',
            f'--set {name} click_script="open {item["url"]} ; sketchybar -m --set upcoming popup.drawing=off"'
        ]

    os.system('sketchybar -m ' + ' '.join(args))

def get_drawed_events():
    cmd = "sketchybar --query upcoming | jq \".popup | .items\""
    output = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
    return json.loads(output.decode('utf-8'))

def plugin_clean(popup_items = ()):
    events_drawed = get_drawed_events()

    if events_drawed is None:
        return

    popup_items = list(popup_items)
    for i in range(len(popup_items)):
        popup_items[i] = "upcoming." + popup_items[i]['uid']
        
    args = []
    for item_name in events_drawed:
        if item_name not in popup_items:
            args += [
                f'--remove "{item_name}"'
            ]

    os.system('sketchybar -m ' + ' '.join(args))

if __name__ == '__main__':
    events = get_events()

    plugin_clean(({'uid': e.uid, 'text': e.human_str, 'url': e.url, 'calendar': e.calendar} for e in events))

    if len(events) == 0:
        plugin_undraw()
    else:
        main_text = generate_main_text(events)
        plugin_draw(main_text, ({'uid': e.uid, 'text': e.human_str, 'url': e.url, 'calendar': e.calendar} for e in events))