From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 21 Nov 2012 02:53:55 +0000
Subject: [PATCH 39/42] sh-pfc: Remove pinmux_info definition
Message-Id: <1353466438-10929-40-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The pinmux_info alias to sh_pfc_soc_info isn't needed anymore, remove
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 include/linux/sh_pfc.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/sh_pfc.h b/include/linux/sh_pfc.h
index 9fd6228..13049c4 100644
--- a/include/linux/sh_pfc.h
+++ b/include/linux/sh_pfc.h
@@ -114,9 +114,6 @@ struct sh_pfc_soc_info {
 	unsigned long unlock_reg;
 };
 
-/* XXX compat for now */
-#define pinmux_info sh_pfc_soc_info
-
 enum { GPIO_CFG_DRYRUN, GPIO_CFG_REQ, GPIO_CFG_FREE };
 
 /* helper macro for port */
-- 
1.7.8.6

