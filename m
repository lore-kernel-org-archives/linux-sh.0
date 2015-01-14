From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 14 Jan 2015 12:11:19 +0000
Subject: [PATCH v2 1/6] PM / Domains: R-Mobile SYSC: Document SH-Mobile AG5 (sh73a0) binding
Message-Id: <1421237484-16847-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

SH-Mobile AG5 (sh73a0) can be handled by the existing bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes
---
 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
index 2460476808e9333e..cc3b1f0a9b1a2b75 100644
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
1.9.1

