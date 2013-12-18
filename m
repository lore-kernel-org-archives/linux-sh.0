From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Wed, 18 Dec 2013 15:08:22 +0000
Subject: [PATCH] arm: shmobile: r8a7790: Fix I2C controller names
Message-Id: <1387379302-20223-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The R8A7790 is an R-Car Gen2 SoC. The clock division factor
(CDF) width is 3 bits on Gen2 as opposed to 2 bits on Gen1.
Fix the device names for R8A7790 SoC to make the R-Car I2C
driver configure the hardware properly.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 8 ++++----
 arch/arm/mach-shmobile/setup-r8a7790.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 81f45a0..18d836b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -297,13 +297,13 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
 	CLKDEV_DEV_ID("e6508000.i2c", &mstp_clks[MSTP931]),
-	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP931]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.0", &mstp_clks[MSTP931]),
 	CLKDEV_DEV_ID("e6518000.i2c", &mstp_clks[MSTP930]),
-	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP930]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.1", &mstp_clks[MSTP930]),
 	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP929]),
-	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP929]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.2", &mstp_clks[MSTP929]),
 	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
-	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP928]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.3", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("r8a7790-vin.0", &mstp_clks[MSTP811]),
 	CLKDEV_DEV_ID("r8a7790-vin.1", &mstp_clks[MSTP810]),
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 8474818..77fd7ed 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -85,7 +85,7 @@ static struct resource i2c_resources[] __initdata = {
 
 #define r8a7790_register_i2c(idx)		\
 	platform_device_register_simple(	\
-		"i2c-rcar", idx,		\
+		"i2c-rcar_gen2", idx,		\
 		i2c_resources + (2 * idx), 2);	\
 
 void __init r8a7790_pinmux_init(void)
-- 
1.8.3.1

