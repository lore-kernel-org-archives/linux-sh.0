From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 04 Feb 2015 13:52:44 +0000
Subject: [PATCH 1/3] PM / Domains: R-Mobile SYSC: Document R-Mobile APE6 (r8a73a4) binding
Message-Id: <1423057966-23321-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1423057966-23321-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1423057966-23321-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

R-Mobile APE6 (r8a73a4) is handled fine by the same driver and bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
index cc3b1f0a9b1a2b75..beda7d2efc304350 100644
--- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
@@ -11,6 +11,7 @@ Required properties:
 - compatible: Should be "renesas,sysc-<soctype>", "renesas,sysc-rmobile" as
 	      fallback.
 	      Examples with soctypes are:
+		- "renesas,sysc-r8a73a4" (R-Mobile APE6)
 		- "renesas,sysc-r8a7740" (R-Mobile A1)
 		- "renesas,sysc-sh73a0" (SH-Mobile AG5)
 - reg: Two address start and address range blocks for the device:
-- 
1.9.1

