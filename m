From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 11 Jan 2016 01:39:20 +0000
Subject: [PATCH] serial: sh-sci: Add device tree support for r8a7792
Message-Id: <1452476360-20972-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9nn7tnt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9nn7tnt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Simply document new compat strings.
There appears to be no need for a driver updates.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
* Broken out of a larger patch the remainder of which has
  already been accepted into tty-next
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 401b1b33c2c4..528c3b90f23c 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -19,6 +19,8 @@ Required properties:
     - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2-W) SCIFA compatible UART.
     - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2-W) SCIFB compatible UART.
     - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2-W) HSCIF compatible UART.
+    - "renesas,scif-r8a7792" for R8A7792 (R-Car V2H) SCIF compatible UART.
+    - "renesas,hscif-r8a7792" for R8A7792 (R-Car V2H) HSCIF compatible UART.
     - "renesas,scif-r8a7793" for R8A7793 (R-Car M2-N) SCIF compatible UART.
     - "renesas,scifa-r8a7793" for R8A7793 (R-Car M2-N) SCIFA compatible UART.
     - "renesas,scifb-r8a7793" for R8A7793 (R-Car M2-N) SCIFB compatible UART.
-- 
2.7.0.rc3.207.g0ac5344

