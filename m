From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 May 2014 23:32:29 +0000
Subject: [PATCH 01/04] ARM: shmobile: Add r8a7740 Maximum CPU Frequency to DTS
Message-Id: <20140507233229.29712.29821.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140507233219.29712.9253.sendpatchset@w520>
In-Reply-To: <20140507233219.29712.9253.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add 800 MHz to the r8a7740 DTS to describe the maximum CPU frequency.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a7740.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/boot/dts/r8a7740.dtsi
+++ work/arch/arm/boot/dts/r8a7740.dtsi	2014-04-24 17:50:40.000000000 +0900
@@ -22,6 +22,7 @@
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0x0>;
+			clock-frequency = <800000000>;
 		};
 	};
 
