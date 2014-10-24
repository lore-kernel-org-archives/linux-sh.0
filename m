From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 24 Oct 2014 11:31:52 +0000
Subject: [PATCH] clocksource: sh_tmu: Document r8a7778 binding
Message-Id: <1414150312-5542-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The r8a7778 is very similar to the r8a7779, and already handled by
the current driver in the non-DT case.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "clocksource: sh_tmu: Document R-Mobile r8a7740 binding"

 Documentation/devicetree/bindings/timer/renesas,tmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
index 4ae7910af09ffcb4..cd5f20bf2582e742 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
@@ -10,6 +10,7 @@ Required Properties:
 
   - compatible: must contain one or more of the following:
     - "renesas,tmu-r8a7740" for the r8a7740 TMU
+    - "renesas,tmu-r8a7778" for the r8a7778 TMU
     - "renesas,tmu-r8a7779" for the r8a7779 TMU
     - "renesas,tmu" for any TMU.
       This is a fallback for the above renesas,tmu-* entries
-- 
1.9.1

