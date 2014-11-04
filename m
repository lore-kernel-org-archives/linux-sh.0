From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 04 Nov 2014 01:48:49 +0000
Subject: [PATCH 15/23 v3] ARM: shmobile: koelsch: fixup I2C2 clock frequency
Message-Id: <87egtj91me.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Koelsch I2C2 has 400kHz settings,
but, ak4643 audio codec chip which is connected to I2C2 can't
work such frequency.
Fixup I2C2 clock frequency to 100kHz.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - use 100kHz

 arch/arm/boot/dts/r8a7791-koelsch.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 523ae4d..ee8ef59 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -425,7 +425,7 @@
 	pinctrl-names = "default";
 
 	status = "okay";
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 
 	composite-in@20 {
 		compatible = "adi,adv7180";
-- 
1.7.9.5

