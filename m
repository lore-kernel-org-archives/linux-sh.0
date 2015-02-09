From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 09 Feb 2015 08:23:34 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: Enable DMA for HSUSB
Message-Id: <1423470214-7140-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423470214-7140-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1423470214-7140-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add DMA properties to the HSUSB node.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 737b578..8dd62fb 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -670,6 +670,9 @@
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
+		dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+		       <&usb_dmac1 0>, <&usb_dmac1 1>;
+		dma-names = "rx0", "tx1", "rx2", "tx3";
 		status = "disabled";
 	};
 
-- 
1.7.9.5

