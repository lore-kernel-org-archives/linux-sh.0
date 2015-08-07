From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 07 Aug 2015 03:16:06 +0000
Subject: [PATCH 04/16 v5][RFC] clk: shmobile: Add r8a7795 SoC to MSTP bindings
Message-Id: <8737zveqqb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v4 -> v5

 - separate to Documentation only

 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index 16ed181..4169c76 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -19,6 +19,7 @@ Required Properties:
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2-W) MSTP gate clocks
     - "renesas,r8a7793-mstp-clocks" for R8A7793 (R-Car M2-N) MSTP gate clocks
     - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
+    - "renesas,r8a7795-mstp-clocks" for R8A7795 (R-Car H3) MSTP gate clocks
     - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
     and "renesas,cpg-mstp-clocks" as a fallback.
   - reg: Base address and length of the I/O mapped registers used by the MSTP
-- 
1.9.1

