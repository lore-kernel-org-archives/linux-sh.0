From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 30 Oct 2014 01:50:48 +0000
Subject: [PATCH 1/3] clocksource: sh_tmu: Document R-Mobile r8a7740 binding
Message-Id: <ec95a345198fc97022c98b44446c96b31d693882.1414629281.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1414629281.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1414629281.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Compared to the r8a7779, the r8a7740 lacks the input capture register,
which is not used by the driver (the current driver already handles the
r8a7740 in the non-DT case).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
index 7db89fb..4ae7910 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
@@ -1,4 +1,4 @@
-* Renesas R-Car Timer Unit (TMU)
+* Renesas R-Mobile/R-Car Timer Unit (TMU)
 
 The TMU is a 32-bit timer/counter with configurable clock inputs and
 programmable compare match.
@@ -9,6 +9,7 @@ are independent. The TMU hardware supports up to three channels.
 Required Properties:
 
   - compatible: must contain one or more of the following:
+    - "renesas,tmu-r8a7740" for the r8a7740 TMU
     - "renesas,tmu-r8a7779" for the r8a7779 TMU
     - "renesas,tmu" for any TMU.
       This is a fallback for the above renesas,tmu-* entries
-- 
2.1.1

