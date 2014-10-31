From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Oct 2014 08:02:59 +0000
Subject: [PATCH 07/12] ARM: shmobile: koelsch: fixup overkill I2C2 clock frequency
Message-Id: <87r3xo1xak.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Koelsch I2C2 has 400kHz settings,
but, ak4643 audio codec chip which is connected to I2C2 can't
work such frequency.
Fixup I2C2 clock frequency.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index f722821..1ad9fb3 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -425,7 +425,6 @@
 	pinctrl-names = "default";
 
 	status = "okay";
-	clock-frequency = <400000>;
 
 	composite-in@20 {
 		compatible = "adi,adv7180";
-- 
1.7.9.5

