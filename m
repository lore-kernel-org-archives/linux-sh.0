From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Nov 2014 01:20:07 +0000
Subject: [PATCH 16/25] ARM: shmobile: koelsch: fixup I2C2 clock frequency
Message-Id: <091fffde6d5a41e388ba7823e51151144da8ced5.1415755881.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415755881.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Koelsch I2C2 has 400kHz settings,
but, ak4643 audio codec chip which is connected to I2C2 can't
work such frequency.
Fixup I2C2 clock frequency to 100kHz.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 191f32b..59e4251 100644
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
2.1.1

