From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Nov 2014 01:20:01 +0000
Subject: [PATCH 10/25] ARM: shmobile: lager: fixup IIC2 clock frequency
Message-Id: <c6f242e2fe485a12a2ee8ef96346be5a2c26e5d9.1415755881.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415755881.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Lager IIC2 is using default clock frequency,
but, ak4643 audio codec chip needs 100kHz
This patch clarifies IIC2 clock frequency as 100kHz.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 ++
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
2.1.1

