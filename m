From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 07:12:30 +0000
Subject: [PATCH 00/03] irqchip: renesas-irqc: r8a7795 and generic chip update
Message-Id: <20150917071230.29299.32326.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

irqchip: renesas-irqc: r8a7795 and generic chip update

[PATCH 01/03] irqchip: renesas-irqc: Add r8a7795 IRQC DT documentation
[PATCH 02/03] irqchip: renesas-irqc: Move over to generic chip
[PATCH 03/03] irqchip: renesas-irqc: Enable nested lock

This series updates the IRQC driver with generic chip support including
nested locking. Also the DT documentation is extended with r8a7795
support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

Written against renesas-drivers-2015-09-08-v4.2

 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt |    1 
 drivers/irqchip/Kconfig                                                 |    1 
 drivers/irqchip/irq-renesas-irqc.c                                      |   81 +++-------
 3 files changed, 33 insertions(+), 50 deletions(-)
