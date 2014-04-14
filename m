From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Apr 2014 17:00:40 +0000
Subject: [PATCH] clk: Improve clock-indices binding documentation
Message-Id: <1397494840-22420-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Geert Uytterhoeven <geert+renesas@glider.be>

Improve the wording for the clock-indices binding documentation.
Also replace "empty nodes" by "empty strings", as reported before by Sergei
Shtylyov.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/clock/clock-bindings.txt   |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
index 700e7aac3717..f15787817d6b 100644
--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -44,10 +44,9 @@ For example:
   clocks by index. The names should reflect the clock output signal
   names for the device.
 
-clock-indices:	   If the identifyng number for the clocks in the node
-		   is not linear from zero, then the this mapping allows
-		   the mapping of identifiers into the clock-output-names
-		   array.
+clock-indices:	   If the identifying number for the clocks in the node
+		   is not linear from zero, then this allows the mapping of
+		   identifiers into the clock-output-names array.
 
 For example, if we have two clocks <&oscillator 1> and <&oscillator 3>:
 
@@ -58,7 +57,7 @@ For example, if we have two clocks <&oscillator 1> and <&oscillator 3>:
 		clock-output-names = "clka", "clkb";
 	}
 
-	This ensures we do not have any empty nodes in clock-output-names
+	This ensures we do not have any empty strings in clock-output-names
 
 
 =Clock consumers=
-- 
1.7.9.5

