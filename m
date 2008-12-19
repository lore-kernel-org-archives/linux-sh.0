From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Dec 2008 03:02:16 +0000
Subject: [PATCH] sh: add LCDC interrupt configuration to AP325 and Migo-R
Message-Id: <20081219030216.13139.55727.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add LCDC interrupt resources for AP325 and Migo-R. The LCDC driver does
not require interrupts at this point, but changes such as one-shot SYS
mode using deferred io, and wait-for-vblank will both need this.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-ap325rxa.c   |    4 ++++
 arch/sh/boards/mach-migor/setup.c |    4 ++++
 2 files changed, 8 insertions(+)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2008-12-18 13:51:39.000000000 +0900
@@ -197,6 +197,10 @@ static struct resource lcdc_resources[] 
 		.end	= 0xfe941fff,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		.start	= 28,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 static struct platform_device lcdc_device = {
--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-12-18 13:51:33.000000000 +0900
@@ -274,6 +274,10 @@ static struct resource migor_lcdc_resour
 		.end	= 0xfe941fff,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		.start	= 28,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 static struct platform_device migor_lcdc_device = {
