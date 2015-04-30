From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:19:03 +0000
Subject: [PATCH v2 14/15] clk: shmobile: Add r8a7793 SoC to MSTP bindings
Message-Id: <1430403544-26742-15-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org, horms@verge.net.au, linux-sh@vger.kernel.org
Cc: magnus.damm@gmail.com, laurent.pinchart+renesas@ideasonboard.com, kuninori.morimoto.gx@renesas.com, linus.walleij@linaro.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Michael Turquette <mturquette@linaro.org>, devicetree@vger.kernel.org

Also replaces "R-Car M2" with "R-Car M2-W" to avoid confusion.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Michael Turquette <mturquette@linaro.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index 0a80fa7..923ee0f 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -15,7 +15,8 @@ Required Properties:
     - "renesas,r8a7740-mstp-clocks" for R8A7740 (R-Mobile A1) MSTP gate clocks
     - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks
     - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
-    - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
+    - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2-W) MSTP gate clocks
+    - "renesas,r8a7793-mstp-clocks" for R8A7793 (R-Car M2-N) MSTP gate clocks
     - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
     - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
     - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
-- 
2.3.5

