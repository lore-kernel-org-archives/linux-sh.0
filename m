From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 02 Jul 2015 05:01:11 +0000
Subject: [PATCH] ARM: shmobile: tidyup Renesas generic MSTP gate clocks compatible name
Message-Id: <87a8vfm9zb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index 0a80fa7..a4075c9 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -18,7 +18,7 @@ Required Properties:
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
     - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
     - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
-    - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
+    - "renesas,cpg-mstp-clocks" for generic MSTP gate clocks
   - reg: Base address and length of the I/O mapped registers used by the MSTP
     clocks. The first register is the clock control register and is mandatory.
     The second register is the clock status register and is optional when not
-- 
1.9.1

