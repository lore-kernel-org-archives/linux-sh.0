From: Rich Felker <dalias@libc.org>
Date: Wed, 27 Jul 2016 05:35:08 +0000
Subject: [PATCH v4 0/2] J-Core interrupt controller support
Message-Id: <cover.1469595860.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

This driver is used with the J2, an open-source VHDL reimplementation
of SH-2.

I've split this out from the main J-Core support patches going
upstream through my own linux-sh tree. Changes since the v3 stem out
of reworking the DT to use separate reg ranges per cpu rather than
cpu-offset. The intent is to avoid out-of-mapping arithmetic via
cpu-offset and to avoid artifically restricting how the hardware lays
out the mappings, but this also allows the cpu notifier logic which
was present before to be removed with simple iteration over the reg
ranges present in its place.

Rich


Rich Felker (2):
  of: add J-Core interrupt controller bindings
  irqchip: add J-Core AIC driver

 .../bindings/interrupt-controller/jcore,aic.txt    | 26 +++++++
 drivers/irqchip/Kconfig                            |  6 ++
 drivers/irqchip/Makefile                           |  1 +
 drivers/irqchip/irq-jcore-aic.c                    | 79 ++++++++++++++++++++++
 4 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
 create mode 100644 drivers/irqchip/irq-jcore-aic.c

-- 
2.8.1

