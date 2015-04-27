From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 Apr 2015 12:55:26 +0000
Subject: [PATCH 02/10] ARM: shmobile: r8a7778 dtsi: Use generic names for device nodes
Message-Id: <1430139334-15272-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

irqpin -> interrupt-controller

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 868f9730953350e9..7ce9f5fd586504f2 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -68,7 +68,7 @@
 	};
 
 	/* irqpin: IRQ0 - IRQ3 */
-	irqpin: irqpin@fe78001c {
+	irqpin: interrupt-controller@fe78001c {
 		compatible = "renesas,intc-irqpin-r8a7778", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
-- 
1.9.1

