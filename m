From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Oct 2013 01:32:22 +0000
Subject: [PATCH 6/7] ARM: shmobile: r8a7778: add MMCIF support on DTSI
Message-Id: <87vc1dzuqk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index a6308a3..02be72e 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -116,4 +116,12 @@
 		compatible = "renesas,pfc-r8a7778";
 		reg = <0xfffc000 0x118>;
 	};
+
+	mmcif: mmcif@ffe4e000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0xffe4e000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 61 4>;
+		status = "disabled";
+	};
 };
-- 
1.7.9.5

