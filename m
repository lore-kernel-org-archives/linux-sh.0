From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:47:40 +0000
Subject: [PATCH 2/2] serial: sh-sci: Fix compatible string in DT bindings example
Message-Id: <1391669260-23970-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1391669260-23970-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1391669260-23970-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Remove the -generic suffix from the compatible string in the serial port
DT bindings example.

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index f372cf2..53e6c17 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -37,7 +37,7 @@ Example:
 	};
 
 	scifa0: serial@e6c40000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.5.2

