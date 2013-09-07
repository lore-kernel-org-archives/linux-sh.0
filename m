From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 07 Sep 2013 00:29:33 +0000
Subject: [PATCH v2 3/4] ARM: shmobile: bockw-reference: add Ether DT support
Message-Id: <201309070429.34126.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the BOCK-W board dependent part of the Ether device node. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7778-bockw-reference.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ renesas/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -30,3 +30,14 @@
 		reg = <0x60000000 0x10000000>;
 	};
 };
+
+&ether {
+	status = "ok";
+	phy-mode = "rmii";
+	phy-handle = <&phy1>;
+	renesas,no-ether-link;
+
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};

