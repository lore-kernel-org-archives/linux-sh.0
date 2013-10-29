From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 29 Oct 2013 22:37:47 +0000
Subject: [PATCH v2 12/19] irda: sh_irda: Enable the driver on all ARM platforms
Message-Id: <1383086274-11049-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
COMPILE_TEST.

Cc: Samuel Ortiz <samuel@sortiz.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/net/irda/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index 2a30193..e04b907 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -403,7 +403,7 @@ config MCS_FIR
 
 config SH_IRDA
 	tristate "SuperH IrDA driver"
-	depends on IRDA && ARCH_SHMOBILE
+	depends on IRDA && (ARM || COMPILE_TEST)
 	help
 	  Say Y here if your want to enable SuperH IrDA devices.
 
-- 
1.8.1.5

