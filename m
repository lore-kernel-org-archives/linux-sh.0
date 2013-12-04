From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 04 Dec 2013 12:05:37 +0000
Subject: [PATCH 00/02] irqchip: renesas-irqc: Lazy disable and mask-on-suspend
Message-Id: <20131204120537.29642.942.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

irqchip: renesas-irqc: Lazy disable and mask-on-suspend

[PATCH 01/02] irqchip: renesas-irqc: Use lazy disable
[PATCH 02/02] irqchip: renesas-irqc: Enable mask on suspend

Update the IRQC driver to use lazy disable and mask on suspend. This fixes
the Suspend-to-RAM behavior to make sure wakeup sources are left enabled
while suspending.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.13-rc2-20131202

 drivers/irqchip/irq-renesas-irqc.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
