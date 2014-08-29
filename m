From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 29 Aug 2014 18:15:09 +0000
Subject: [PATCH v2 5/6] ARM: shmobile: r8a7794: document SCIF clock support
Message-Id: <1409336110-32734-6-git-send-email-ulrich.hecht+renesas@gmail.com>
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
index b355660..7b87eb2 100644
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
1.8.4.5

