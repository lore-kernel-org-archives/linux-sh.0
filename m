From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 03 Jan 2017 23:06:31 +0000
Subject: [PATCH 11/19] sh: Don't set the sh-sci platform data REIE bit when not implemented
Message-Id: <20170103230639.19660-12-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

According to the datasheets, the sh7760 SIM and sh7723 SCIFA instances
don't implement the REIE bit. Don't set it in platform data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  | 1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index 6dbcbf1621aa..e51fe1734e13 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -200,7 +200,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.scscr		= SCSCR_REIE,
 	/*
 	 * This is actually a SIM card module serial port, based on an SCI with
 	 * additional registers. The sh-sci driver doesn't support the SIM port
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 6c5cb234aa33..1c1b3c469831 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -86,7 +86,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -107,7 +106,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -128,7 +126,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
-- 
Regards,

Laurent Pinchart

