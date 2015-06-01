From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 01 Jun 2015 10:21:53 +0000
Subject: [PATCH] clk: shmobile: div6: Document mandatory compatible fallback
Message-Id: <1433154113-19013-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The generic CPG DIV6 clock compatible value is mandatory, as the driver
uses only this value for matching.  Document that this is a fallback
that must be present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index 3e40c41b05658e5b..5ddb68418655d569 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -14,7 +14,7 @@ Required Properties:
     - "renesas,r8a7793-div6-clock" for R8A7793 (R-Car M2-N) DIV6 clocks
     - "renesas,r8a7794-div6-clock" for R8A7794 (R-Car E2) DIV6 clocks
     - "renesas,sh73a0-div6-clock" for SH73A0 (SH-Mobile AG5) DIV6 clocks
-    - "renesas,cpg-div6-clock" for generic DIV6 clocks
+    and "renesas,cpg-div6-clock" as a fallback.
   - reg: Base address and length of the memory resource used by the DIV6 clock
   - clocks: Reference to the parent clock(s); either one, four, or eight
     clocks must be specified.  For clocks with multiple parents, invalid
-- 
1.9.1

