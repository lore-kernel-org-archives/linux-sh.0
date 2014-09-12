From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 12 Sep 2014 08:51:15 +0000
Subject: [PATCH 5/6] ARM: shmobile: ape6evm: sort dts file by address
Message-Id: <1410511876-9235-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410511876-9235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1410511876-9235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, Olof Johansson <olof@lixom.net>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 36 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index ce085fa..23e9925 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -20,24 +20,6 @@
 		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
 	};
 
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0 0x40000000 0 0x40000000>;
-	};
-
-	memory@200000000 {
-		device_type = "memory";
-		reg = <2 0x00000000 0 0x40000000>;
-	};
-
-	ape6evm_fixed_3v3: fixedregulator@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
 	lbsc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -55,6 +37,24 @@
 			vddvario-supply = <&ape6evm_fixed_3v3>;
 		};
 	};
+
+	ape6evm_fixed_3v3: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	memory@200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x40000000>;
+	};
 };
 
 &i2c5 {
-- 
1.8.4.5

