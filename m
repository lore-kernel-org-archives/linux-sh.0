From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 26 Mar 2009 00:24:01 +0000
Subject: [PATCH] urquell: enable LAN device
Message-Id: <uy6usbxk0.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
This patch is for linux-next

 arch/sh/boards/board-urquell.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-urquell.c b/arch/sh/boards/board-urquell.c
index 17036ce..66361c6 100644
--- a/arch/sh/boards/board-urquell.c
+++ b/arch/sh/boards/board-urquell.c
@@ -129,6 +129,10 @@ static int __init urquell_devices_setup(void)
 	gpio_request(GPIO_FN_USB_OVC0,  NULL);
 	gpio_request(GPIO_FN_USB_PENC0, NULL);
 
+	/* enable LAN */
+	ctrl_outw(ctrl_inw(UBOARDREG(IRL2MSKR)) & ~0x00000001,
+		  UBOARDREG(IRL2MSKR));
+
 	return platform_add_devices(urquell_devices,
 				    ARRAY_SIZE(urquell_devices));
 }
-- 
1.5.6.3

