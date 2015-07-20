From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 20 Jul 2015 10:06:02 +0000
Subject: [PATCH 00/03] irqchip: renesas-irqc: Minor update
Message-Id: <20150720100602.2552.85507.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

irqchip: renesas-irqc: Minor update

[PATCH 01/03] irqchip: renesas-irqc: Get rid of IRQF_VALID
[PATCH 02/03] irqchip: renesas-irqc: Use linear IRQ domain
[PATCH 03/03] irqchip: renesas-irqc: Make use of irq_find_mapping()

This series contains a few minor updates for the IRQC driver, some
basic cleanups as preparation series for future generic chip rework.

With these patches applied the driver is becoming less special
and closer to the generic chip implementation.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---
 Written against renesas-devel-20150720-v4.2-rc3

 drivers/irqchip/irq-renesas-irqc.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)
