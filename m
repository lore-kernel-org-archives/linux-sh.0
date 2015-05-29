From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 May 2015 09:36:31 +0000
Subject: [PATCH 3/3] clk: shmobile: rz: Document mandatory compatible fallback
Message-Id: <1432892191-24039-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1432892191-24039-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432892191-24039-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The generic RZ CPG compatible value is mandatory, as the driver uses
only this value for matching.  Document that this is a fallback that
must be present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
index c5666288e409ebd2..2a2c509f5f9d8553 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
@@ -9,7 +9,7 @@ Required Properties:
 
   - compatible: Must be one of
     - "renesas,r7s72100-cpg-clocks" for the r7s72100 CPG
-    - "renesas,rz-cpg-clocks" for the generic RZ CPG
+    and "renesas,rz-cpg-clocks" as a fallback.
   - reg: Base address and length of the memory resource used by the CPG
   - clocks: References to possible parent clocks. Order must match clock modes
     in the datasheet. For the r7s72100, this is extal, usb_x1.
-- 
1.9.1

