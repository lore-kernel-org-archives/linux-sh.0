From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 27 Aug 2015 19:02:27 +0000
Subject: [PATCH 1/5] [RFC] spi: sh-msiof: Add support for R-Car H3
Message-Id: <1440702151-1406-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for MSIOF in r8a7795 (R-Car H3).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
---
As of commit 8ed545ee4d491d6f ("spi: sh-msiof: Fix FIFO size to 64 word
from 256 word") the default rx fifo size in the driver is actually 64
instead of 256 on R-Car Gen2 (and now also on R-Car Gen3), but the DT
binding documentation was not updated.

As the datasheet for R-Car Gen3 still states 256, and there's still some
confusion of FIFO size vs. transfer size length, I think this is still
an open issue.

Note that the aforementioned commit has a CC to
stable@vger.kernel.org...
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 3 ++-
 drivers/spi/spi-sh-msiof.c                         | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 8f771441be60556a..29356a4c9843b743 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -10,6 +10,7 @@ Required properties:
 			 "renesas,msiof-r8a7792" (R-Car V2H)
 			 "renesas,msiof-r8a7793" (R-Car M2-N)
 			 "renesas,msiof-r8a7794" (R-Car E2)
+			 "renesas,msiof-r8a7795" (R-Car H3)
 - reg                  : A list of offsets and lengths of the register sets for
 			 the device.
 			 If only one register set is present, it is to be used
@@ -51,7 +52,7 @@ Optional properties, deprecated for soctype-specific bindings:
 - renesas,tx-fifo-size : Overrides the default tx fifo size given in words
 			 (default is 64)
 - renesas,rx-fifo-size : Overrides the default rx fifo size given in words
-			 (default is 64, or 256 on R-Car Gen2)
+			 (default is 64, or 256 on R-Car Gen2/Gen3)
 
 Pinctrl properties might be needed, too.  See
 Documentation/devicetree/bindings/pinctrl/renesas,*.
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index a7934ab00b96505f..3a4bc04a61b7b513 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -978,6 +978,7 @@ static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7793",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7794",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7795",   .data = &r8a779x_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_msiof_match);
-- 
1.9.1

