From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 27 Aug 2015 19:02:28 +0000
Subject: [PATCH 2/5] clk: shmobile: r8a7795: Document DIV6 clock bindings
Message-Id: <1440702151-1406-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index 5ddb68418655d569..a6889fb8a5bd2a48 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -13,6 +13,7 @@ Required Properties:
     - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2-W) DIV6 clocks
     - "renesas,r8a7793-div6-clock" for R8A7793 (R-Car M2-N) DIV6 clocks
     - "renesas,r8a7794-div6-clock" for R8A7794 (R-Car E2) DIV6 clocks
+    - "renesas,r8a7795-div6-clock" for R8A7795 (R-Car H3) DIV6 clocks
     - "renesas,sh73a0-div6-clock" for SH73A0 (SH-Mobile AG5) DIV6 clocks
     and "renesas,cpg-div6-clock" as a fallback.
   - reg: Base address and length of the memory resource used by the DIV6 clock
-- 
1.9.1

