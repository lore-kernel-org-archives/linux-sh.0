From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 14 Nov 2014 15:59:31 +0000
Subject: [PATCH 1/2] serial: sh-sci: Add device tree support for r8a7794
Message-Id: <1415980772-13287-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Simply document the new compat string.
There appears to be no need for a driver update.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[geert: Reworded to match previous commits]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index b3556609a06fb8b9..7b87eb2c66be3131 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -20,6 +20,10 @@ Required properties:
     - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
     - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
     - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
+    - "renesas,scif-r8a7794" for R8A7794 (R-Car E2) SCIF compatible UART.
+    - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
+    - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
+    - "renesas,hscif-r8a7794" for R8A7794 (R-Car E2) HSCIF compatible UART.
     - "renesas,scif" for generic SCIF compatible UART.
     - "renesas,scifa" for generic SCIFA compatible UART.
     - "renesas,scifb" for generic SCIFB compatible UART.
-- 
1.9.1

