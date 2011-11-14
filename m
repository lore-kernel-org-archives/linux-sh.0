From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 14 Nov 2011 00:22:27 +0000
Subject: [update][PATCH 0/7] PM / Domains: Per-device callbacks and PM QoS
Message-Id: <201111140122.27328.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201111070101.33960.rjw@sisk.pl>
In-Reply-To: <201111070101.33960.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

Hi,

This is the second iteration of the patchset introducing per-device callbacks
and PM QoS support to PM domains.

All patches have been updated, the second one have been folded into the
first one and there's one more patch in  the series.  Please look into the
changelogs for more details.

[1/7] - Make it possible to define per-device start/stop and .active_wakeup()
        routines.

[2/7] - Introduce "save/restore state" device callbacks.

[3/7] - Introduce per-device PM domain callbacks for system suspend.

[4/7] - Make runtime PM core take device PM QoS constraints into account.

[5/7] - Add device "stop governor".

[6/7] - Add domain "power off governor".

[7/7] - Automatically update overoptimistic latency information.

The patchset have been tested for backwards compatibility, but it still needs
some testing for the new features it adds.

Thanks,
Rafael

