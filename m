From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 01 Aug 2012 07:54:58 +0000
Subject: [PATCH 2/2] sh: ecovec: care CN5 VBUS if USB host mode
Message-Id: <871ujrdp2o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

renesas_usbhs driver can control both USB Host/Gadget,
but it needs VBUS output if Host mode.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 4158d70..7f41c85 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -242,9 +242,17 @@ static int usbhs_get_id(struct platform_device *pdev)
 	return gpio_get_value(GPIO_PTB3);
 }
 
+static void usbhs_phy_reset(struct platform_device *pdev)
+{
+	/* enable vbus if HOST */
+	if (!gpio_get_value(GPIO_PTB3))
+		gpio_set_value(GPIO_PTB5, 1);
+}
+
 static struct renesas_usbhs_platform_info usbhs_info = {
 	.platform_callback = {
 		.get_id		= usbhs_get_id,
+		.phy_reset	= usbhs_phy_reset,
 	},
 	.driver_param = {
 		.buswait_bwait		= 4,
-- 
1.7.5.4

