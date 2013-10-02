From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 08:34:07 +0000
Subject: [PATCH 4/4 v2] ARM: shmobile: bockw: add SMSC support on DTS
Message-Id: <87d2noysub.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4f7uoxx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4f7uoxx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables INTC IRQ and SMSC on BockW board via DT.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - patch was splited, only dts

 arch/arm/boot/dts/r8a7778-bockw-reference.dts |   27 ++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 9bb903a..4425fd2 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -22,11 +22,36 @@
 	compatible = "renesas,bockw-reference", "renesas,r8a7778";
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel rw";
+		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
 	};
 
 	memory {
 		device_type = "memory";
 		reg = <0x60000000 0x10000000>;
 	};
+
+	fixedregulator3v3: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	lan0@18300000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x18300000 0x1000>;
+
+		phy-mode = "mii";
+		interrupt-parent = <&irqpin>;
+		interrupts = <0 0>; /* IRQ0: hwirq 0 on irqpin */
+		reg-io-width = <4>;
+		vddvario-supply = <&fixedregulator3v3>;
+		vdd33a-supply = <&fixedregulator3v3>;
+	};
+};
+
+&irqpin {
+	status = "okay";
 };
-- 
1.7.9.5

