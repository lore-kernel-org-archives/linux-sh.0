From: Rich Felker <dalias@libc.org>
Date: Thu, 28 Jul 2016 06:52:36 +0000
Subject: [PATCH v5 0/2] J-Core interrupt controller support
Message-Id: <cover.1469688756.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

Updated based on feedback from Mark Rutland.

Rich Felker (2):
  of: add J-Core interrupt controller bindings
  irqchip: add J-Core AIC driver

 .../bindings/interrupt-controller/jcore,aic.txt    | 26 +++++++
 drivers/irqchip/Kconfig                            |  6 ++
 drivers/irqchip/Makefile                           |  1 +
 drivers/irqchip/irq-jcore-aic.c                    | 86 ++++++++++++++++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
 create mode 100644 drivers/irqchip/irq-jcore-aic.c

-- 
2.8.1

