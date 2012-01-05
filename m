From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 05 Jan 2012 05:41:48 +0000
Subject: [PATCH 2/2] sh: enable the SUDMAC of renesas_usbhs in board-sh7757lcr
Message-Id: <4F05381C.9050205@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch depends on the following patch:
  - usb: renesas_usbhs: add support for SUDMAC

 arch/sh/boards/board-sh7757lcr.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 0838154..40872e8 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -276,6 +276,8 @@ static struct renesas_usbhs_platform_info usb0_data = {
 	},
 	.driver_param = {
 		.buswait_bwait = 5,
+		.d0_tx_id = SHDMA_SLAVE_SUDMAC00,
+		.has_sudmac = 1,
 	}
 };

@@ -288,7 +290,7 @@ static struct resource usb0_resources[] = {
 	[1] = {
 		.start	= 50,
 		.end	= 50,
-		.flags	= IORESOURCE_IRQ,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
 	},
 };

-- 
1.7.1
