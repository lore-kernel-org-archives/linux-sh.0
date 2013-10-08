From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Oct 2013 01:52:19 +0000
Subject: Re: [PATCH 2/4] ARM: shmobile: r8a7778: add I2C support on DTSI
Message-Id: <20131008015217.GC16625@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2qsth2z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2qsth2z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 03, 2013 at 11:44:15PM -0700, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up however I am unsure if it will
appear in v3.13 or v3.14.

There was some minor fuzz when applying this change.
What I have queued up is below, please check that it is correct.

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[PATCH] ARM: shmobile: r8a7778: add I2C support on DTSI

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 5d08f116..0ee6e86 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -117,4 +117,44 @@
 		reg = <0xfffc000 0x118>;
 		#gpio-range-cells = <3>;
 	};
+
+	i2c0: i2c@ffc70000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc70000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 67 0x4>;
+		status = "disabled";
+	};
+
+	i2c1: i2c@ffc71000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc71000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 78 0x4>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@ffc72000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc72000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 76 0x4>;
+		status = "disabled";
+	};
+
+	i2c3: i2c@ffc73000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc73000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 77 0x4>;
+		status = "disabled";
+	};
 };
-- 
1.8.4

