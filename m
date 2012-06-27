From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 27 Jun 2012 09:26:34 +0000
Subject: [PATCH] sh: kfr2r09: fix compile breakage
Message-Id: <Pine.LNX.4.64.1206271125530.24173@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix compile breakage caused by

commit aa82f9fcd0062782dcbe29a2c820ba7c04dbe572
Author: Paul Mundt <lethal@linux-sh.org>

    sh: kfr2r09 evt2irq migration.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

needed for 3.5

 arch/sh/boards/mach-kfr2r09/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 9dff4ff..f2a4304 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -203,8 +203,8 @@ static struct resource kfr2r09_usb0_gadget_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= evtirq(0xa20),
-		.end	= evtirq(0xa20),
+		.start	= evt2irq(0xa20),
+		.end	= evt2irq(0xa20),
 		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
 	},
 };
-- 
1.7.2.5

