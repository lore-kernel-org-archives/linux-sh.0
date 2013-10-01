From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 01 Oct 2013 04:11:38 +0000
Subject: [PATCH 2/3] ARM: shmobile: Add r8a7790 CA15 CPU cores
Message-Id: <c1f95979baa9c33c5e6c280d7a8742fad0d20326.1380600579.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <c1f95979baa9c33c5e6c280d7a8742fad0d20326.1380530263.git.horms+renesas@verge.net.au>
In-Reply-To: <c1f95979baa9c33c5e6c280d7a8742fad0d20326.1380530263.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add CA15 CPU cores to r8a7790 for a total of 4 x CA15.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 3b879e7..388f49f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -24,6 +24,27 @@
 			reg = <0>;
 			clock-frequency = <1300000000>;
 		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+			clock-frequency = <1300000000>;
+		};
 	};
 
 	gic: interrupt-controller@f1001000 {
-- 
1.8.4

