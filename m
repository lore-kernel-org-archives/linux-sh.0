From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 10:39:05 +0000
Subject: [PATCH] sh: drop static UIO clocks for sh7722, sh7723 and sh7724
Message-Id: <20090819103905.12389.36202.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

The Runtime PM patch for UIO driver implements coarse grained
dynamic power management for UIO devices. With that patch in
place we can get rid of the static clock configuration. Which
in turn makes it possible for cpuidle to enter deeper sleep.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Also for the sh/pm-runtime topic branch.

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    6 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |    6 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2009-08-17 19:00:49.000000000 +0900
@@ -164,11 +164,11 @@ static struct clk mstp_clks[] = {
 	SH_HWBLK_CLK("2dg0", -1, B_CLK, HWBLK_2DG, 0),
 	SH_HWBLK_CLK("siu0", -1, B_CLK, HWBLK_SIU, 0),
 	SH_HWBLK_CLK("vou0", -1, B_CLK, HWBLK_VOU, 0),
-	SH_HWBLK_CLK("jpu0", -1, B_CLK, HWBLK_JPU, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("jpu0", -1, B_CLK, HWBLK_JPU, 0),
 	SH_HWBLK_CLK("beu0", -1, B_CLK, HWBLK_BEU, 0),
 	SH_HWBLK_CLK("ceu0", -1, B_CLK, HWBLK_CEU, 0),
-	SH_HWBLK_CLK("veu0", -1, B_CLK, HWBLK_VEU, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("vpu0", -1, B_CLK, HWBLK_VPU, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("veu0", -1, B_CLK, HWBLK_VEU, 0),
+	SH_HWBLK_CLK("vpu0", -1, B_CLK, HWBLK_VPU, 0),
 	SH_HWBLK_CLK("lcdc0", -1, P_CLK, HWBLK_LCDC, 0),
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2009-08-17 19:01:11.000000000 +0900
@@ -190,12 +190,12 @@ static struct clk mstp_clks[] = {
 	SH_HWBLK_CLK("usb0", -1, B_CLK, HWBLK_USB, 0),
 	SH_HWBLK_CLK("2dg0", -1, B_CLK, HWBLK_2DG, 0),
 	SH_HWBLK_CLK("siu0", -1, B_CLK, HWBLK_SIU, 0),
-	SH_HWBLK_CLK("veu1", -1, B_CLK, HWBLK_VEU2H1, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("veu1", -1, B_CLK, HWBLK_VEU2H1, 0),
 	SH_HWBLK_CLK("vou0", -1, B_CLK, HWBLK_VOU, 0),
 	SH_HWBLK_CLK("beu0", -1, B_CLK, HWBLK_BEU, 0),
 	SH_HWBLK_CLK("ceu0", -1, B_CLK, HWBLK_CEU, 0),
-	SH_HWBLK_CLK("veu0", -1, B_CLK, HWBLK_VEU2H0, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("vpu0", -1, B_CLK, HWBLK_VPU, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("veu0", -1, B_CLK, HWBLK_VEU2H0, 0),
+	SH_HWBLK_CLK("vpu0", -1, B_CLK, HWBLK_VPU, 0),
 	SH_HWBLK_CLK("lcdc0", -1, B_CLK, HWBLK_LCDC, 0),
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2009-08-17 19:02:08.000000000 +0900
@@ -204,17 +204,17 @@ static struct clk mstp_clks[] = {
 	SH_HWBLK_CLK("2dg0", -1, B_CLK, HWBLK_2DG, 0),
 	SH_HWBLK_CLK("sdhi0", -1, B_CLK, HWBLK_SDHI0, 0),
 	SH_HWBLK_CLK("sdhi1", -1, B_CLK, HWBLK_SDHI1, 0),
-	SH_HWBLK_CLK("veu1", -1, B_CLK, HWBLK_VEU1, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("veu1", -1, B_CLK, HWBLK_VEU1, 0),
 	SH_HWBLK_CLK("ceu1", -1, B_CLK, HWBLK_CEU1, 0),
 	SH_HWBLK_CLK("beu1", -1, B_CLK, HWBLK_BEU1, 0),
 	SH_HWBLK_CLK("2ddmac0", -1, SH_CLK, HWBLK_2DDMAC, 0),
 	SH_HWBLK_CLK("spu0", -1, B_CLK, HWBLK_SPU, 0),
-	SH_HWBLK_CLK("jpu0", -1, B_CLK, HWBLK_JPU, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("jpu0", -1, B_CLK, HWBLK_JPU, 0),
 	SH_HWBLK_CLK("vou0", -1, B_CLK, HWBLK_VOU, 0),
 	SH_HWBLK_CLK("beu0", -1, B_CLK, HWBLK_BEU0, 0),
 	SH_HWBLK_CLK("ceu0", -1, B_CLK, HWBLK_CEU0, 0),
-	SH_HWBLK_CLK("veu0", -1, B_CLK, HWBLK_VEU0, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("vpu0", -1, B_CLK, HWBLK_VPU, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("veu0", -1, B_CLK, HWBLK_VEU0, 0),
+	SH_HWBLK_CLK("vpu0", -1, B_CLK, HWBLK_VPU, 0),
 	SH_HWBLK_CLK("lcdc0", -1, B_CLK, HWBLK_LCDC, 0),
 };
 
