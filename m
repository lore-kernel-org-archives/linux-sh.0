From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 May 2015 09:36:29 +0000
Subject: [PATCH 1/3] clk: shmobile: mstp: Document mandatory compatible fallback
Message-Id: <1432892191-24039-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1432892191-24039-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432892191-24039-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The generic MSTP gate clocks compatible value is mandatory, as the
driver uses only this value for matching.  Document that this is a
fallback that must be present.

Also fix a typo (missing plural "s") in the compatible value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index 0a80fa70ca265c0f..237ff1c8dd632fc3 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -18,7 +18,7 @@ Required Properties:
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
     - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
     - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
-    - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
+    and "renesas,cpg-mstp-clocks" as a fallback.
   - reg: Base address and length of the I/O mapped registers used by the MSTP
     clocks. The first register is the clock control register and is mandatory.
     The second register is the clock status register and is optional when not
-- 
1.9.1

