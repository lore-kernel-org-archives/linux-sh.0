From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 Apr 2015 12:55:31 +0000
Subject: [PATCH 07/10] ARM: shmobile: ape6evm dts: Use generic names for device nodes
Message-Id: <1430139334-15272-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

max8973 -> regulator

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 81a38ceee098087e..a4c425923c05e8cd 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -147,7 +147,7 @@
 
 &i2c5 {
 	status = "okay";
-	vdd_dvfs: max8973@1b {
+	vdd_dvfs: regulator@1b {
 		compatible = "maxim,max8973";
 		reg = <0x1b>;
 
-- 
1.9.1

