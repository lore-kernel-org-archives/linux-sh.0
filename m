From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 20 Feb 2014 08:03:20 +0000
Subject: [PATCH V2] i2c: rcar: add compatible entry for r8a7791
Message-Id: <1392883400-4396-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@sang-engineering.com>

From: Wolfram Sang <wsa@sang-engineering.com>

While we are here, also brush up the devicetree binding documentation.
The example was an inappropriate copy from the sh_mobile driver.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 14 ++++++++++----
 drivers/i2c/busses/i2c-rcar.c                      |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 897cfcd5..dd8b2dd 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -6,6 +6,7 @@ Required properties:
 	"renesas,i2c-r8a7778"
 	"renesas,i2c-r8a7779"
 	"renesas,i2c-r8a7790"
+	"renesas,i2c-r8a7791"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: interrupt specifier.
@@ -13,11 +14,16 @@ Required properties:
 Optional properties:
 - clock-frequency: desired I2C bus clock frequency in Hz. The absence of this
   propoerty indicates the default frequency 100 kHz.
+- clocks: clock specifier.
 
 Examples :
 
-i2c0: i2c@e6500000 {
-	compatible = "renesas,i2c-rcar-h2";
-	reg = <0 0xe6500000 0 0x428>;
-	interrupts = <0 174 0x4>;
+i2c0: i2c@e6508000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "renesas,i2c-r8a7791";
+	reg = <0 0xe6508000 0 0x40>;
+	interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
+	clock-frequency = <400000>;
 };
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 0282d4d..cc60bc6 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -638,6 +638,7 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
+	{ .compatible = "renesas,i2c-r8a7791", .data = (void *)I2C_RCAR_GEN2 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
-- 
1.8.5.1

