From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 28 Sep 2015 09:42:19 +0000
Subject: [PATCH v2 00/02] irqchip: renesas-irqc: r8a7795 and generic chip update V2
Message-Id: <20150928094219.32552.18778.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

irqchip: renesas-irqc: r8a7795 and generic chip update V2

[PATCH v2 01/02] irqchip: renesas-irqc: Add r8a7795 INTC-EX DT documentation
[PATCH v2 02/02] irqchip: renesas-irqc: Move over to nested generic chip

This series updates the IRQC driver with generic chip support including
nested locking. Also the DT documentation is extended with r8a7795
support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against v4.3-rc3, thanks to Geert and Tglx for their help!

 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt |    1 
 drivers/irqchip/Kconfig                                                 |    1 
 drivers/irqchip/irq-renesas-irqc.c                                      |   86 +++-------
