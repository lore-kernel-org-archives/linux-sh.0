From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Feb 2014 16:29:15 +0000
Subject: [PATCH 1/4] spi: rspi: List full example compatible properties in bindings
Message-Id: <1393000158-6622-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

List full example compatible properties with soctypes instead of just the
soctypes, so checkpatch can validate DTSes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
index 95f9b21d239f..e54924b2aff6 100644
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -7,9 +7,11 @@ Required properties:
 		     "renesas,rspi-<soctype>", "renesas,rspi-rz" as fallback.
 		     For Quad Serial Peripheral Interface on R-Car Gen2:
 		     "renesas,qspi-<soctype>", "renesas,qspi" as fallback.
-		     Examples of valid soctypes are "sh7757" (SH),
-		     "r7s72100" (RZ/A1H), "r8a7790" (R-Car H2), and
-		     "r8a7791" (R-Car M2).
+		     Examples with soctypes are:
+		        - "renesas,rspi-sh7757" (SH)
+			- "renesas,rspi-r7s72100" (RZ/A1H)
+			- "renesas,qspi-r8a7790" (R-Car H2)
+			- "renesas,qspi-r8a7791" (R-Car M2)
 - reg              : Address start and address range size of the device
 - interrupts       : A list of interrupt-specifiers, one for each entry in
 		     interrupt-names.
-- 
1.7.9.5

