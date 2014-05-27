From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 27 May 2014 12:17:31 +0000
Subject: [PATCH 1/2] i2c: rcar: add compatibles for additional SoC
Message-Id: <1401193052-8582-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 3 +++
 drivers/i2c/busses/i2c-rcar.c                      | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index dd8b2dd1edeb..16b3e07aa98f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -7,6 +7,9 @@ Required properties:
 	"renesas,i2c-r8a7779"
 	"renesas,i2c-r8a7790"
 	"renesas,i2c-r8a7791"
+	"renesas,i2c-r8a7792"
+	"renesas,i2c-r8a7793"
+	"renesas,i2c-r8a7794"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: interrupt specifier.
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 06d47aafbb79..467eafa050a6 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -646,6 +646,9 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,i2c-r8a7791", .data = (void *)I2C_RCAR_GEN2 },
+	{ .compatible = "renesas,i2c-r8a7792", .data = (void *)I2C_RCAR_GEN2 },
+	{ .compatible = "renesas,i2c-r8a7793", .data = (void *)I2C_RCAR_GEN2 },
+	{ .compatible = "renesas,i2c-r8a7794", .data = (void *)I2C_RCAR_GEN2 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
-- 
2.0.0.rc2

