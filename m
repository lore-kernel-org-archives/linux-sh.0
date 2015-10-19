From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 19 Oct 2015 14:07:40 +0000
Subject: [PATCH/RFT 7/7] ARM: shmobile: lager dts: specify default-input for ADV7612
Message-Id: <1445263660-6945-8-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ian Molton <ian.molton@codethink.co.uk>

Set the 'default-input' property for ADV7612, enabling image and video
capture without the need to have userspace specifying routing.

(This version places the property in the adv7612 node, in line with
Ian's documentation)

Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
Signed-off-by: William Towle <william.towle@codethink.co.uk>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index ed77476..b7d0ad0 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -556,6 +556,7 @@
 		interrupt-parent = <&gpio1>;
 		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
 		remote = <&vin0>;
+		default-input = <0>;
 
 		port {
 			adv7612: endpoint {
-- 
2.6.1

