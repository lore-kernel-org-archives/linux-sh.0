From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 06 Mar 2015 17:09:56 +0000
Subject: [PATCH 09/11] serial: sh-sci: Add device tree bindings for r8a7793
Message-Id: <1425661798-10487-10-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index ae73bb0..6b879b5 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -19,6 +19,10 @@ Required properties:
     - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
     - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
     - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
+    - "renesas,scif-r8a7793" for R8A7793 (R-Car M2N) SCIF compatible UART.
+    - "renesas,scifa-r8a7793" for R8A7793 (R-Car M2N) SCIFA compatible UART.
+    - "renesas,scifb-r8a7793" for R8A7793 (R-Car M2N) SCIFB compatible UART.
+    - "renesas,hscif-r8a7793" for R8A7793 (R-Car M2N) HSCIF compatible UART.
     - "renesas,scif-r8a7794" for R8A7794 (R-Car E2) SCIF compatible UART.
     - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
     - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
-- 
2.2.2

