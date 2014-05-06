From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 06 May 2014 14:23:53 +0000
Subject: [PATCH 6/6] clk: shmobile: Add r8a7740, sh73a0 SoCs to MSTP bindings
Message-Id: <1399386233-11928-7-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index 5992dce..8514088 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -10,8 +10,10 @@ index in the group, from 0 to 31.
 Required Properties:
 
   - compatible: Must be one of the following
+    - "renesas,r8a7740-mstp-clocks" for R8A7740 MSTP gate clocks
     - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
+    - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
     - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
   - reg: Base address and length of the I/O mapped registers used by the MSTP
     clocks. The first register is the clock control register and is mandatory.
-- 
1.8.4.5

