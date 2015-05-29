From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 May 2015 09:36:30 +0000
Subject: [PATCH 2/3] clk: shmobile: Document mandatory compatible fallback
Message-Id: <1432892191-24039-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1432892191-24039-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432892191-24039-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The generic R-Car Gen2 CPG compatible value is mandatory, as the driver
uses only this value for matching.  Document that this is a fallback
that must be present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index aa2b94511f4d9e05..1dc65fc741b3b4a3 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -12,7 +12,7 @@ Required Properties:
     - "renesas,r8a7791-cpg-clocks" for the r8a7791 CPG
     - "renesas,r8a7793-cpg-clocks" for the r8a7793 CPG
     - "renesas,r8a7794-cpg-clocks" for the r8a7794 CPG
-    - "renesas,rcar-gen2-cpg-clocks" for the generic R-Car Gen2 CPG
+    and "renesas,rcar-gen2-cpg-clocks" as a fallback.
 
   - reg: Base address and length of the memory resource used by the CPG
 
-- 
1.9.1

