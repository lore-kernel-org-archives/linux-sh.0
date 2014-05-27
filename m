From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 27 May 2014 13:45:11 +0000
Subject: [PATCH RFC 3/3] spi: rspi: Add support for new R-Car Gen2 SoCs
Message-Id: <1401198311-21268-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for QSPI in:
  - r8a7792 (R-Car V2H)
  - r8a7793 (R-Car M2-N)
  - r8a7794 (R-Car E2)

r8a7791 is now called "R-Car M2-W".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
index d57d82a74054..92a65e591648 100644
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -11,7 +11,10 @@ Required properties:
 		        - "renesas,rspi-sh7757" (SH)
 			- "renesas,rspi-r7s72100" (RZ/A1H)
 			- "renesas,qspi-r8a7790" (R-Car H2)
-			- "renesas,qspi-r8a7791" (R-Car M2)
+			- "renesas,qspi-r8a7791" (R-Car M2-W)
+			- "renesas,qspi-r8a7792" (R-Car V2H)
+			- "renesas,qspi-r8a7793" (R-Car M2-N)
+			- "renesas,qspi-r8a7794" (R-Car E2)
 - reg              : Address start and address range size of the device
 - interrupts       : A list of interrupt-specifiers, one for each entry in
 		     interrupt-names.
-- 
1.9.1

