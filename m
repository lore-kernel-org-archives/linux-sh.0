From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 17 Dec 2014 16:18:50 +0000
Subject: [PATCH v4 2/6] clk: shmobile: Add r8a73a4 SoC to MSTP bindings
Message-Id: <1418833134-7863-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index a5f5223..e566fb7 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -11,6 +11,7 @@ Required Properties:
 
   - compatible: Must be one of the following
     - "renesas,r7s72100-mstp-clocks" for R7S72100 (RZ) MSTP gate clocks
+    - "renesas,r8a73a4-mstp-clocks" for R8A73A4 (R-Mobile APE6) MSTP gate clocks
     - "renesas,r8a7740-mstp-clocks" for R8A7740 (R-Mobile A1) MSTP gate clocks
     - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks
     - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
-- 
1.8.4.5

