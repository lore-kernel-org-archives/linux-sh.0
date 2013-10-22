From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Oct 2013 02:36:02 +0000
Subject: [PATCH 04/12] ARM: shmobile: r8a7779: tidyup DT node naming
Message-Id: <871u3em3qo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch tidies up DT node name and related clock.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779.dtsi         |    8 ++++----
 arch/arm/mach-shmobile/clock-r8a7779.c |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index be737ef..05fd41c 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -207,7 +207,7 @@
 		interrupts = <0 100 0x4>;
 	};
 
-	sdhi0: sdhi@ffe4c000 {
+	sdhi0: sd@ffe4c000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4c000 0x100>;
 		interrupt-parent = <&gic>;
@@ -217,7 +217,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi@ffe4d000 {
+	sdhi1: sd@ffe4d000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4d000 0x100>;
 		interrupt-parent = <&gic>;
@@ -227,7 +227,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi@ffe4e000 {
+	sdhi2: sd@ffe4e000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4e000 0x100>;
 		interrupt-parent = <&gic>;
@@ -237,7 +237,7 @@
 		status = "disabled";
 	};
 
-	sdhi3: sdhi@ffe4f000 {
+	sdhi3: sd@ffe4f000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4f000 0x100>;
 		interrupt-parent = <&gic>;
diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 5c83259..b7ce0e7 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -201,13 +201,13 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-hspi.1", &mstp_clks[MSTP007]), /* HSPI1 */
 	CLKDEV_DEV_ID("sh-hspi.2", &mstp_clks[MSTP007]), /* HSPI2 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
-	CLKDEV_DEV_ID("ffe4c000.sdhi", &mstp_clks[MSTP323]), /* SDHI0 */
+	CLKDEV_DEV_ID("ffe4c000.sd", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
-	CLKDEV_DEV_ID("ffe4d000.sdhi", &mstp_clks[MSTP322]), /* SDHI1 */
+	CLKDEV_DEV_ID("ffe4d000.sd", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
-	CLKDEV_DEV_ID("ffe4e000.sdhi", &mstp_clks[MSTP321]), /* SDHI2 */
+	CLKDEV_DEV_ID("ffe4e000.sd", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP320]), /* SDHI3 */
-	CLKDEV_DEV_ID("ffe4f000.sdhi", &mstp_clks[MSTP320]), /* SDHI3 */
+	CLKDEV_DEV_ID("ffe4f000.sd", &mstp_clks[MSTP320]), /* SDHI3 */
 	CLKDEV_DEV_ID("rcar-du-r8a7779", &mstp_clks[MSTP103]), /* DU */
 };
 
-- 
1.7.9.5

