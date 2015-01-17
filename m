From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 17 Jan 2015 00:58:44 +0000
Subject: [PATCH 11/11] PM / Domains: R-Mobile SYSC: Document SH-Mobile AG5 (sh73a0) binding
Message-Id: <fbaa5e694a1240c5f6b829b1e17652e4e228ee12.1421380713.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1421380713.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1421380713.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

SH-Mobile AG5 (sh73a0) can be handled by the existing bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
index 2460476..cc3b1f0 100644
--- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
@@ -12,6 +12,7 @@ Required properties:
 	      fallback.
 	      Examples with soctypes are:
 		- "renesas,sysc-r8a7740" (R-Mobile A1)
+		- "renesas,sysc-sh73a0" (SH-Mobile AG5)
 - reg: Two address start and address range blocks for the device:
          - The first block refers to the normally accessible registers,
          - the second block refers to the registers protected by the HPB
-- 
2.1.4

