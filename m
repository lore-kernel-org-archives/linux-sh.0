From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 20:01:52 +0000
Subject: [PATCH resend 2/3] ARM: shmobile: r8a7790 dtsi: Drop "renesas,rcar_sound" compatible value
Message-Id: <1420574513-15135-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The "renesas,rcar_sound" compatible property value was never processed
nor documented.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index af30c2470f855014..edfa8b844ee2c4c8 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1401,7 +1401,7 @@
 
 	rcar_sound: rcar_sound@ec500000 {
 		#sound-dai-cells = <1>;
-		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
+		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2";
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-- 
1.9.1

