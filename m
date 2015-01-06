From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 20:01:51 +0000
Subject: [PATCH resend 1/3] ARM: shmobile: sh73a0 dtsi: Add SoC-specific FSI2 compatible property
Message-Id: <1420574513-15135-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The FSI2 sound node used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The binding documentation was updated in commit caaeb6a96f35af14 ("ASoC:
sh: fsi: Document SoC-specific bindings"), which is upstream since
v3.19-rc1.
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index e187f167909a88b7..891ed9b6383f58fc 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -354,7 +354,7 @@
 
 	sh_fsi2: sound@ec230000 {
 		#sound-dai-cells = <1>;
-		compatible = "renesas,sh_fsi2";
+		compatible = "renesas,fsi2-sh73a0", "renesas,sh_fsi2";
 		reg = <0xec230000 0x400>;
 		interrupts = <0 146 0x4>;
 		status = "disabled";
-- 
1.9.1

