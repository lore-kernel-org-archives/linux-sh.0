From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 03 Jan 2017 23:06:29 +0000
Subject: [PATCH 09/19] sh: Don't set the sh-sci platform data regshift field
Message-Id: <20170103230639.19660-10-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The regshift value is computed automatically by the driver, there's no
need to set it in platform data. Specify the associated memory resource
lengths to ensure proper computation of the value.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh3/setup-sh770x.c |  1 -
 arch/sh/kernel/cpu/sh4/setup-sh7750.c |  3 +--
 arch/sh/kernel/cpu/sh4/setup-sh7760.c | 10 ++++++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 084a91e6027e..e2a48e957cba 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -111,7 +111,6 @@ static struct platform_device rtc_device = {
 static struct plat_sci_port scif0_platform_data = {
 	.type		= PORT_SCI,
 	.ops		= &sh770x_sci_port_ops,
-	.regshift	= 1,
 };
 
 static struct resource scif0_resources[] = {
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index d98a55416306..57d30689204d 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -39,11 +39,10 @@ static struct platform_device rtc_device = {
 
 static struct plat_sci_port sci_platform_data = {
 	.type		= PORT_SCI,
-	.regshift	= 2,
 };
 
 static struct resource sci_resources[] = {
-	DEFINE_RES_MEM(0xffe00000, 0x100),
+	DEFINE_RES_MEM(0xffe00000, 0x20),
 	DEFINE_RES_IRQ(evt2irq(0x4e0)),
 };
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index 641b85865a63..6dbcbf1621aa 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -201,12 +201,18 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_REIE,
+	/*
+	 * This is actually a SIM card module serial port, based on an SCI with
+	 * additional registers. The sh-sci driver doesn't support the SIM port
+	 * type, declare it as a SCI. Don't declare the additional registers in
+	 * the memory resource or the driver will compute an incorrect regshift
+	 * value.
+	 */
 	.type		= PORT_SCI,
-	.regshift	= 2,
 };
 
 static struct resource scif3_resources[] = {
-	DEFINE_RES_MEM(0xfe480000, 0x100),
+	DEFINE_RES_MEM(0xfe480000, 0x10),
 	DEFINE_RES_IRQ(evt2irq(0xc00)),
 	DEFINE_RES_IRQ(evt2irq(0xc20)),
 	DEFINE_RES_IRQ(evt2irq(0xc40)),
-- 
Regards,

Laurent Pinchart

