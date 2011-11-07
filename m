From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 07 Nov 2011 00:01:33 +0000
Subject: [PATCH 0/7] PM / Domains: Per-device callbacks and PM QoS
Message-Id: <201111070101.33960.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

Hi,

The following patchset makes it possible to define device-specific PM domain
callbacks, allowing device drivers to be designed to support generic PM domains
and work without them as well, and introduces governor functions deciding
whether or not it is beneficial to put devices into low-power states.  The new
code is designed to be backwards compatible, as far as necessary.

[1/7] - Make it possible to defing per-device start/stop routines.
[2/7] - Make it possible to defing per-device .active_wakeup() callbacks.
[3/7] - Introduce "save/restore state" device callbacks.
[4/7] - Introduce per-device PM domain callbacks for system suspend.
[5/7] - Add device "stop governor".
[6/7] - Add domain "power off governor".
[7/7] - Automatically update overoptimistic latency information.

Please refer to the changelogs for more information.

The patches haven't been fully tested yet, so most likely there still are some
rough edges here and there.

Thanks,
Rafael

