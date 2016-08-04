From: Rich Felker <dalias@libc.org>
Date: Thu, 04 Aug 2016 04:30:37 +0000
Subject: [PATCH v6 0/2] J-Core timer support
Message-Id: <cover.147018b3518.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1470183518.git.dalias@libc.org>
In-Reply-To: <cover.1470183518.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

Updated to include changes requested by Thomas Gleixner. Aside from
minor style improvements, the main changes are moving from the old cpu
notifier framework for cpu starting to the cpuhotplug framework. Since
the new framework does not easily facilitate multiple driver instances
without significant additional code, and since there is presently no
need for multiple instances, the (now-only-nominal) support for
multiple instances was removed; this simplifies some of the code. Use
of the full 64-bit clocksource was also replaced by 32-bit to avoid
expensive (non-native, software) 64-bit arithmetic in hot paths.

I've also removed a comment about Linux implementation details from
the DT binding document since it's not actually part of the bindings.

Finally, driver was made conditional in Kconfig to avoid it showing up
in configurations where it's not relevant.

Rich


Rich Felker (2):
  of: add J-Core timer bindings
  clocksource: add J-Core timer/clocksource driver

 .../devicetree/bindings/timer/jcore,pit.txt        |  24 ++
 drivers/clocksource/Kconfig                        |   9 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/jcore-pit.c                    | 242 +++++++++++++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 5 files changed, 277 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
 create mode 100644 drivers/clocksource/jcore-pit.c

-- 
2.8.1

