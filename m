From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Dec 2013 05:03:04 +0000
Subject: [PATCH 02/04] ARM: shmobile: Genmai SCIF2 PINCTRL configuration
Message-Id: <20131217050304.727.24761.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131217050232.727.9552.sendpatchset@w520>
In-Reply-To: <20131217050232.727.9552.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Configure the r7s72100 PINCTRL hardware and select pin function
for the SCIF2 serial console.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- 0009/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts	2013-11-27 17:13:43.000000000 +0900
@@ -58,3 +58,13 @@
 	};
 
 };
+
+&pfc {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
+	scif2_pins: serial2 {
+		renesas,groups = "scif2_txd_p3_0", "scif2_rxd_p3_2";
+		renesas,function = "scif2";
+	};
+};
