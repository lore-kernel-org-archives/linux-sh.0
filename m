From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 09 Sep 2015 12:57:11 +0000
Subject: [PATCH trivial] clk: shmobile: div6: Grammar s/They/Their/
Message-Id: <1441803431-30460-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Jiri Kosina <trivial@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index a6889fb8a5bd2a48..e1bdf14ac2dfdab2 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -1,7 +1,7 @@
 * Renesas CPG DIV6 Clock
 
 The CPG DIV6 clocks are variable factor clocks provided by the Clock Pulse
-Generator (CPG). They clock input is divided by a configurable factor from 1
+Generator (CPG). Their clock input is divided by a configurable factor from 1
 to 64.
 
 Required Properties:
-- 
1.9.1

