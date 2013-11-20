From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Nov 2013 00:07:40 +0000
Subject: [PATCH] ARM: shmobile: Use r8a7790 suffix for IRQC compat string
Message-Id: <20131120000740.27032.66529.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120000553.27024.20445.sendpatchset@w520>
In-Reply-To: <20131120000553.27024.20445.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add "renesas,irqc-r8a7790" to the compatible string for IRQC
in case of r8a7790. This makes the IRQC follow the same style
as the other devices and also makes it more future proof.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0003/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-11-20 08:20:30.000000000 +0900
@@ -171,7 +171,7 @@
 	};
 
 	irqc0: interrupt-controller@e61c0000 {
-		compatible = "renesas,irqc";
+		compatible = "renesas,irqc-r8a7790", "renesas,irqc";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0 0xe61c0000 0 0x200>;
