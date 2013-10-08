From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Oct 2013 03:39:01 +0000
Subject: [PATCH 01/08] ARM: shmobile: r8a7791 PFC device tree node
Message-Id: <20131008033901.20455.32324.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131008033851.20455.68845.sendpatchset@w520>
In-Reply-To: <20131008033851.20455.68845.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a DT node for the r8a7791 PFC device.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7791.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-10-04 18:31:44.000000000 +0900
@@ -71,4 +71,10 @@
 			      <0 16 4>,
 			      <0 17 4>;
 	};
+
+	pfc: pfc@e6060000 {
+		compatible = "renesas,pfc-r8a7791";
+		reg = <0 0xe6060000 0 0x250>;
+		#gpio-range-cells = <3>;
+	};
 };
