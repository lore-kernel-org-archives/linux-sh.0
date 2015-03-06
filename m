From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 06 Mar 2015 17:09:57 +0000
Subject: [PATCH 10/11] clk: shmobile: Add r8a7793 SoC to MSTP bindings
Message-Id: <1425661798-10487-11-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index 0a80fa7..f5ea999 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -16,6 +16,7 @@ Required Properties:
     - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks
     - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
+    - "renesas,r8a7793-mstp-clocks" for R8A7793 (R-Car M2N) MSTP gate clocks
     - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
     - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
     - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
-- 
2.2.2

