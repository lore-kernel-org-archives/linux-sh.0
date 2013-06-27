From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Jun 2013 09:47:58 +0000
Subject: [PATCH 3/3] ARM: shmobile: ape6evm: add CPUFreq support
Message-Id: <1372326479-15028-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326479-15028-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372326479-15028-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds OPPs to the CA15 DT node and a max8973 DT node to support
clock and voltage scaling, using the cpufreq-cpu0 CPUFreq driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 4fb0102..5c56f23 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -52,3 +52,25 @@
 		};
 	};
 };
+
+&i2c5 {
+	vdd_dvfs: max8973@1b {
+		compatible = "maxim,max8973";
+		reg = <0x1b>;
+
+		regulator-min-microvolt = <935000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&cpu0 {
+	cpu0-supply = <&vdd_dvfs>;
+	operating-points = <
+		/* kHz  uV */
+		1950000 1115000
+		1462500  995000
+	>;
+	voltage-tolerance = <1>; /* 1% */
+};
-- 
1.7.2.5

