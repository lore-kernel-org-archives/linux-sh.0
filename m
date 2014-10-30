From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 30 Oct 2014 05:55:20 +0000
Subject: [PATCH/RFC] ARM: shmobile: lager: Add I2C2 clock frequency to device tree
Message-Id: <1414648520-30184-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
[simon: rebased]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

If this is useful I wonder if it is should be set in the lager board DTS
file instead of the r8a7790 SoC DTSI file.


 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 830f2e8..32c7e48 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -426,6 +426,7 @@
 
 &iic2	{
 	status = "ok";
+	clock-frequency = <400000>;
 	pinctrl-0 = <&iic2_pins>;
 	pinctrl-names = "default";
 
-- 
2.1.1

