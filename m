From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 22 Jul 2013 16:21:45 +0000
Subject: [PATCH v2 3/3] ARM: shmobile: kzm9g-reference: use GPIO for card detection on SDHI2
Message-Id: <1374510105-21896-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On kzm9g GPIO 13 is connected to card detection on the SDHI2 slot. Add it
to the device tree node.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

So far this only enables polling of the GPIO, because irqpin GPIO-to-IRQ
is currently not functioning on shmobile in the DT case. The reason for the
problem is, that shmobile currently uses a static GPIO-to-IRQ mapping with
a fixed offset, whereas with DT the mapping is dynamic. As soon as this
problem is fixed, this binding will enable the use of a card-detection IRQ
instead of polling.

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index e5b84d1c..c9976af 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -252,7 +252,7 @@
 
 	vmmc-supply = <&vmmc_sdhi2>;
 	bus-width = <4>;
-	broken-cd;
+	cd-gpios = <&pfc 13 GPIO_ACTIVE_LOW>;
 	dmas = <&dmac 0xcd
 		&dmac 0xce>;
 	dma-names = "tx", "rx";
-- 
1.7.2.5

