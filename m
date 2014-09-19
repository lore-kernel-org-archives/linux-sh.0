From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 19 Sep 2014 04:14:14 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific irqc compatible property
Message-Id: <34abee398119acaed0b1fb4318eca5b364cf74e2.1411099817.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1411099817.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1411099817.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The interrupt controller used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index fba39a2..ef152e3 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -51,7 +51,7 @@
 	};
 
 	irqc0: interrupt-controller@e61c0000 {
-		compatible = "renesas,irqc";
+		compatible = "renesas,irqc-r8a73a4", "renesas,irqc";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0 0xe61c0000 0 0x200>;
@@ -90,7 +90,7 @@
 	};
 
 	irqc1: interrupt-controller@e61c0200 {
-		compatible = "renesas,irqc";
+		compatible = "renesas,irqc-r8a73a4", "renesas,irqc";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0 0xe61c0200 0 0x200>;
-- 
2.0.1

