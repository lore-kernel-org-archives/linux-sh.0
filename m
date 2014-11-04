From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 04 Nov 2014 01:47:46 +0000
Subject: [PATCH 09/23 v3] ARM: shmobile: lager: fixup IIC2 clock frequency
Message-Id: <87mw8791o5.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Lager IIC2 is using default clock frequency,
but, ak4643 audio codec chip needs 100kHz
This patch clarifies IIC2 clock frequency as 100kHz.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - new patch

 arch/arm/boot/dts/r8a7790-lager.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 830f2e8..86fb2ee 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -429,6 +429,8 @@
 	pinctrl-0 = <&iic2_pins>;
 	pinctrl-names = "default";
 
+	clock-frequency = <100000>;
+
 	composite-in@20 {
 		compatible = "adi,adv7180";
 		reg = <0x20>;
-- 
1.7.9.5

