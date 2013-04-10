From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 10 Apr 2013 22:19:49 +0000
Subject: [PATCH/RFC 6/6] ARM: shmobile: kzm9g-reference: add DMA channels to the MMCIF DT
Message-Id: <1365632389-2249-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1365632389-2249-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1365632389-2249-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

The MMCIF driver can use DMA for data transfer, add suitable
Device Tree bindings.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index ed9dd45..e1d0d5d 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -156,6 +156,9 @@
 	bus-width = <8>;
 	vmmc-supply = <&reg_1p8v>;
 	status = "okay";
+	dmas = <&dma0 0xd1
+		&dma0 0xd2>;
+	dma-names = "tx", "rx";
 };
 
 &sdhi0 {
-- 
1.7.2.5

