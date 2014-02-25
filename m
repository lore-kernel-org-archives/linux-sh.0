From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Feb 2014 10:21:08 +0000
Subject: [PATCH v2 1/6] spi: sh-msiof: Improve bindings
Message-Id: <1393323673-2751-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1393323673-2751-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1393323673-2751-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Documentation:
  - Add missing "interrupt-parent", "#address-cells", "#size-cells", and
    "clocks" properties,
  - Add missing default values for "num-cs", "renesas,tx-fifo-size" and
    "renesas,rx-fifo-size",
  - Add a reference to the pinctrl documentation.

Implementation:
  - As "num-cs" is marked optional, provide a sensible default.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: devicetree@vger.kernel.org
---
v2:
  - As num-cs is marked optional, provide a sensible default

 Documentation/devicetree/bindings/spi/sh-msiof.txt |   24 ++++++++++++++------
 drivers/spi/spi-sh-msiof.c                         |    2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index e6222106ca36..eae3c8c9300e 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -1,12 +1,22 @@
 Renesas MSIOF spi controller
 
 Required properties:
-- compatible : 	"renesas,sh-msiof" for SuperH or
-		"renesas,sh-mobile-msiof" for SH Mobile series
-- reg : Offset and length of the register set for the device
-- interrupts : interrupt line used by MSIOF
+- compatible           : "renesas,sh-msiof" for SuperH, or
+			 "renesas,sh-mobile-msiof" for SH Mobile series.
+- reg                  : Offset and length of the register set for the device
+- interrupt-parent     : The phandle for the interrupt controller that
+			 services interrupts for this device
+- interrupts           : Interrupt specifier
+- #address-cells       : Must be <1>
+- #size-cells          : Must be <0>
 
 Optional properties:
-- num-cs		: total number of chip-selects
-- renesas,tx-fifo-size	: Overrides the default tx fifo size given in words
-- renesas,rx-fifo-size	: Overrides the default rx fifo size given in words
+- clocks               : Must contain a reference to the functional clock.
+- num-cs               : Total number of chip-selects (default is 1)
+- renesas,tx-fifo-size : Overrides the default tx fifo size given in words
+			 (default is 64)
+- renesas,rx-fifo-size : Overrides the default rx fifo size given in words
+			 (default is 64)
+
+Pinctrl properties might be needed, too.  See
+Documentation/devicetree/bindings/pinctrl/renesas,*.
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 92515c1ececa..bbe963018e1a 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -663,7 +663,7 @@ static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
 {
 	struct sh_msiof_spi_info *info;
 	struct device_node *np = dev->of_node;
-	u32 num_cs = 0;
+	u32 num_cs = 1;
 
 	info = devm_kzalloc(dev, sizeof(struct sh_msiof_spi_info), GFP_KERNEL);
 	if (!info) {
-- 
1.7.9.5

