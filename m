From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Jun 2013 07:28:23 +0000
Subject: [PATCH 5/5] ARM: shmobile: marzen: keep local function as static
Message-Id: <1370503703-31024-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370503703-31024-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370503703-31024-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

marzen_init_late() should be static

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 9105285..d9c494e 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -349,7 +349,7 @@ static struct platform_device *marzen_late_devices[] __initdata = {
 	&ohci1_device,
 };
 
-void __init marzen_init_late(void)
+static void __init marzen_init_late(void)
 {
 	/* get usb phy */
 	phy = usb_get_phy(USB_PHY_TYPE_USB2);
-- 
1.8.2.1

