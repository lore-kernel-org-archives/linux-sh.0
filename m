From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 06 Mar 2015 17:09:54 +0000
Subject: [PATCH 07/11] clk: shmobile: r8a7793: document DIV6 clock bindings
Message-Id: <1425661798-10487-8-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index 054f65f..6bada02 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -11,6 +11,7 @@ Required Properties:
     - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
     - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
     - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
+    - "renesas,r8a7793-div6-clock" for R8A7793 (R-Car M2N) DIV6 clocks
     - "renesas,sh73a0-div6-clock" for SH73A0 (SH-Mobile AG5) DIV6 clocks
     - "renesas,cpg-div6-clock" for generic DIV6 clocks
   - reg: Base address and length of the memory resource used by the DIV6 clock
-- 
2.2.2

