From: Rich Felker <dalias@libc.org>
Date: Thu, 28 Jul 2016 06:56:15 +0000
Subject: [PATCH v5 0/2] J-Core timer support
Message-Id: <cover.1469688975.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

The only difference since v4 should be merging of Arnd Bergmann's
patch that addresses the API change whereby init functions can return
an error.

Rich



Rich Felker (2):
  of: add J-Core timer bindings
  clocksource: add J-Core timer/clocksource driver

 .../devicetree/bindings/timer/jcore,pit.txt        |  25 ++
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/jcore-pit.c                    | 283 +++++++++++++++++++++
 4 files changed, 317 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
 create mode 100644 drivers/clocksource/jcore-pit.c

-- 
2.8.1

