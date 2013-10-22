From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Oct 2013 02:36:13 +0000
Subject: [PATCH 05/12] ARM: shmobile: r8a7790: tidyup DT node naming
Message-Id: <87zjq2kp5x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch tidies up DT node name and related clock.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi         |   10 +++++-----
 arch/arm/mach-shmobile/clock-r8a7790.c |   12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ee845fa..5ae7db6 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -225,7 +225,7 @@
 		status = "disabled";
 	};
 
-	mmcif1: mmcif@ee220000 {
+	mmcif1: mmc@ee220000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
 		interrupt-parent = <&gic>;
@@ -239,7 +239,7 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
-	sdhi0: sdhi@ee100000 {
+	sdhi0: sd@ee100000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -248,7 +248,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi@ee120000 {
+	sdhi1: sd@ee120000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -257,7 +257,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi@ee140000 {
+	sdhi2: sd@ee140000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -266,7 +266,7 @@
 		status = "disabled";
 	};
 
-	sdhi3: sdhi@ee160000 {
+	sdhi3: sd@ee160000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee160000 0 0x100>;
 		interrupt-parent = <&gic>;
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index a64f965..ab3cbeb 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -283,17 +283,17 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
-	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
+	CLKDEV_DEV_ID("ee200000.mmc", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
-	CLKDEV_DEV_ID("ee100000.sdhi", &mstp_clks[MSTP314]),
+	CLKDEV_DEV_ID("ee100000.sd", &mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]),
-	CLKDEV_DEV_ID("ee120000.sdhi", &mstp_clks[MSTP313]),
+	CLKDEV_DEV_ID("ee120000.sd", &mstp_clks[MSTP313]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]),
-	CLKDEV_DEV_ID("ee140000.sdhi", &mstp_clks[MSTP312]),
+	CLKDEV_DEV_ID("ee140000.sd", &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP312]),
-	CLKDEV_DEV_ID("ee160000.sdhi", &mstp_clks[MSTP311]),
+	CLKDEV_DEV_ID("ee160000.sd", &mstp_clks[MSTP311]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP311]),
-	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
+	CLKDEV_DEV_ID("ee220000.mmc", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 };
-- 
1.7.9.5

