From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 07:12:39 +0000
Subject: [PATCH 01/03] irqchip: renesas-irqc: Add r8a7795 IRQC DT documentation
Message-Id: <20150917071239.29299.75042.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917071230.29299.32326.sendpatchset@little-apple>
In-Reply-To: <20150917071230.29299.32326.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Add r8a7795 to the IRQC DT binding document.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt |    1 +
 1 file changed, 1 insertion(+)

--- 0001/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ work/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt	2015-09-15 20:06:50.390513000 +0900
@@ -10,6 +10,7 @@ Required properties:
     - "renesas,irqc-r8a7792" (R-Car V2H)
     - "renesas,irqc-r8a7793" (R-Car M2-N)
     - "renesas,irqc-r8a7794" (R-Car E2)
+    - "renesas,irqc-r8a7795" (R-Car H3)
 - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
   interrupts.txt in this directory
 - clocks: Must contain a reference to the functional clock.
