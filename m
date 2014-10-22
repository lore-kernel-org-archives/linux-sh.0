From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 22 Oct 2014 09:26:18 +0000
Subject: [PATCH] clocksource: sh_mtu2: Correct SoC family name
Message-Id: <1413969978-15946-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

r7s72100 is a member of the RZ family, not of the R-Car family

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/timer/renesas,mtu2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
index d9a8d5af1a21270f..55484a77a6ae54d0 100644
--- a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
@@ -1,4 +1,4 @@
-* Renesas R-Car Multi-Function Timer Pulse Unit 2 (MTU2)
+* Renesas RZ Multi-Function Timer Pulse Unit 2 (MTU2)
 
 The MTU2 is a multi-purpose, multi-channel timer/counter with configurable
 clock inputs and programmable compare match.
-- 
1.9.1

