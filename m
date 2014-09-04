From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 04 Sep 2014 01:12:25 +0000
Subject: [PATCH 2/5] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific thermal compatible property
Message-Id: <a2cfaa7458e714aa00be98c630afaa1a4766e2ad.1409792871.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1409792871.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1409792871.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The thermal node used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index d8ec505..fba39a2 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -165,7 +165,7 @@
 	};
 
 	thermal@e61f0000 {
-		compatible = "renesas,rcar-thermal";
+		compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
 			 <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.0.1

