From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Apr 2012 11:28:28 +0000
Subject: [PATCH 1/6] sh: switch MSIOF and MMCIF PM clocks to device-ID look-up
Message-Id: <Pine.LNX.4.64.1204181322300.30514@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Matching clocks with devices, using connection IDs is deprecated. Switch
remaining SH platforms to use device-ID look-ups for MSIOF and MMCIF.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
index ea01a72..ba18ccd 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
@@ -245,7 +245,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("tpu0", &mstp_clks[MSTP225]),
 	CLKDEV_CON_ID("irda0", &mstp_clks[MSTP224]),
 	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP218]),
-	CLKDEV_CON_ID("mmcif0", &mstp_clks[MSTP217]),
+	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP217]),
 	CLKDEV_CON_ID("sim0", &mstp_clks[MSTP216]),
 	CLKDEV_CON_ID("keysc0", &mstp_clks[MSTP214]),
 	CLKDEV_CON_ID("tsif0", &mstp_clks[MSTP213]),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
index 7ac07b4..542d1c5 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
@@ -234,7 +234,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP006]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP005]),
 
-	CLKDEV_CON_ID("msiof0", &mstp_clks[MSTP002]),
+	CLKDEV_DEV_ID("spi_sh_msiof.0", &mstp_clks[MSTP002]),
 	CLKDEV_CON_ID("sbr0", &mstp_clks[MSTP001]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP109]),
 	CLKDEV_CON_ID("icb0", &mstp_clks[MSTP227]),
@@ -243,7 +243,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("dacy0", &mstp_clks[MSTP223]),
 	CLKDEV_CON_ID("tsif0", &mstp_clks[MSTP222]),
 	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP218]),
-	CLKDEV_CON_ID("mmcif0", &mstp_clks[MSTP217]),
+	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP217]),
 	CLKDEV_CON_ID("usbf0", &mstp_clks[MSTP211]),
 	CLKDEV_CON_ID("veu1", &mstp_clks[MSTP207]),
 	CLKDEV_CON_ID("vou0", &mstp_clks[MSTP205]),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
index ab1c58f..1060898 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -143,7 +143,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("ssi0_fck", &mstp_clks[MSTP020]),
 	CLKDEV_CON_ID("hac1_fck", &mstp_clks[MSTP017]),
 	CLKDEV_CON_ID("hac0_fck", &mstp_clks[MSTP016]),
-	CLKDEV_CON_ID("mmcif_fck", &mstp_clks[MSTP013]),
+	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP013]),
 	CLKDEV_CON_ID("flctl_fck", &mstp_clks[MSTP012]),
 
 	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[MSTP008]),
-- 
1.7.2.5

