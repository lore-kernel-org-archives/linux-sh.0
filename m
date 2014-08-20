From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 Aug 2014 14:28:32 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a7790 dtsi: Remove superfluous interrupt-parent
Message-Id: <1408544914-21742-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1408544914-21742-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1408544914-21742-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

There's already an "interrupt-parent = <&gic>;" at the top, which is
inherited by all child nodes, so the "interrupt-parent" property in
the sound node can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e2e40e5bbe5c..cf1ba907cad9 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1158,7 +1158,6 @@
 	rcar_sound: rcar_sound@0xec500000 {
 		#sound-dai-cells = <1>;
 		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
-		interrupt-parent = <&gic>;
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-- 
1.9.1

