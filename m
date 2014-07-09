From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 09 Jul 2014 12:23:38 +0000
Subject: [PATCH 08/13] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific thermal compatible property
Message-Id: <1404908623-909-9-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The thermal node used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index f3bd3d4603d7..59145b267862 100644
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
1.9.1

