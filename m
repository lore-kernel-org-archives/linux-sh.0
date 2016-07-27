From: Rich Felker <dalias@libc.org>
Date: Wed, 27 Jul 2016 05:35:09 +0000
Subject: [PATCH v4 0/2] J-Core timer support
Message-Id: <cover.1469594843.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

This driver is used with the J2, an open-source VHDL reimplementation
of SH-2.

I've split this out from the main J-Core support patches going
upstream through my own linux-sh tree. Changes since the v3 are mainly
cleanup/simplification, inclusion of sched_clock support based on
suggestions by Daniel Lezcano, and reworking the DT bindings to use
separate reg ranges per cpu rather than cpu-offset for greater
flexibility.

Rich


Rich Felker (2):
  of: add J-Core timer bindings
  clocksource: add J-Core timer/clocksource driver

 .../devicetree/bindings/timer/jcore,pit.txt        |  25 ++
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/jcore-pit.c                    | 277 +++++++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
 create mode 100644 drivers/clocksource/jcore-pit.c

-- 
2.8.1

