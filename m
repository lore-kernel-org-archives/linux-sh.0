From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 13 Mar 2012 00:23:15 +0000
Subject: [PATCH 0/6] PM / Domains: System suspend fixes and "always on" flag
Message-Id: <201203130123.16268.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Cao Minh Hiep <hiepcm@gmail.com>

Hi all,

The following patches fix system suspend/resume and hibernation device
callback routines in the generic PM domains code and add an "always on" flag
for devices allowing their drivers to protect them from surprise power
removals.

[1/6] - Fix system resume of devices involved in system wakeup.
[2/6] - Fix hibernation restore of devices.
[3/6] - Introduce "always on" flag for "special" devices in PM domains.
[4/6] - Make TMU clocksource driver use the "always on" flag.
[5/6] - Make CMT clocksource driver use the "always on" flag.
[6/6] - Make MTU2 clocksource driver use the "always on" flag.

All of them are v3.4 material if there are no objections.

Thanks,
Rafael
