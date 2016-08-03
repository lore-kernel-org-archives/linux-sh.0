From: Rich Felker <dalias@libc.org>
Date: Wed, 03 Aug 2016 01:08:49 +0000
Subject: [PATCH v6 0/2] J-Core interrupt controller support
Message-Id: <cover.1470186529.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

Updated based on feedback from Thomas Gleixner. Removal of unnecessary
data allowed some simplification. Magic numbers have been replaced
with meaningful (I hope) macro constants, comments added, and minor
style issues fixed.

Also, driver was made conditional in Kconfig to avoid it showing up in
configurations where it's not relevant.

Rich


Rich Felker (2):
  of: add J-Core interrupt controller bindings
  irqchip: add J-Core AIC driver

 .../bindings/interrupt-controller/jcore,aic.txt    | 26 ++++++
 drivers/irqchip/Kconfig                            |  7 ++
 drivers/irqchip/Makefile                           |  1 +
 drivers/irqchip/irq-jcore-aic.c                    | 94 ++++++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
 create mode 100644 drivers/irqchip/irq-jcore-aic.c

-- 
2.8.1

