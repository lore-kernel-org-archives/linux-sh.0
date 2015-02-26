From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 26 Feb 2015 16:42:10 +0000
Subject: [PATCH v4 5/9] ASoC: rsnd: Document r8a7778-specific bindings
Message-Id: <1424968934-30577-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds "renesas,rcar_sound-r8a7778".

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 2dd690b..67c9861 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -5,6 +5,7 @@ Required properties:
 				  "renesas,rcar_sound-gen1" if generation1, and
 				  "renesas,rcar_sound-gen2" if generation2
 				  Examples with soctypes are:
+				    - "renesas,rcar_sound-r8a7778" (R-Car M1)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
 				    - "renesas,rcar_sound-r8a7791" (R-Car M2-W)
 - reg				: Should contain the register physical address.
-- 
2.2.2

