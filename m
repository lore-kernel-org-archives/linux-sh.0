From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Jun 2015 08:57:28 +0000
Subject: [PATCH v2 01/06] ARM: shmobile: r8a7779: Configure IRLM mode via DT
Message-Id: <20150625085728.24543.29200.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r8a7779 SoC DTS and the Marzen Reference
C board code to use DTS only for INTC-IRQPIN IRLM setup.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

 Changes since V1:
 - Fixed unit-address mismatch, thanks Geert!

 arch/arm/boot/dts/r8a7779.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7779.dtsi
+++ work/arch/arm/boot/dts/r8a7779.dtsi	2015-06-25 16:33:46.132366518 +0900
@@ -148,7 +148,7 @@
 		interrupt-controller;
 	};
 
-	irqpin0: interrupt-controller@fe780010 {
+	irqpin0: interrupt-controller@fe78001c {
 		compatible = "renesas,intc-irqpin-r8a7779", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		status = "disabled";
@@ -157,7 +157,8 @@
 			<0xfe780010 4>,
 			<0xfe780024 4>,
 			<0xfe780044 4>,
-			<0xfe780064 4>;
+			<0xfe780064 4>,
+			<0xfe780000 4>;
 		interrupts = <0 27 IRQ_TYPE_LEVEL_HIGH
 			      0 28 IRQ_TYPE_LEVEL_HIGH
 			      0 29 IRQ_TYPE_LEVEL_HIGH
