From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 25 Jan 2013 02:24:55 +0000
Subject: [PATCH 79/80] sh-pfc: Remove pinmux_info definition
Message-Id: <1359080696-31489-80-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The pinmux_info alias to sh_pfc_soc_info isn't needed anymore, remove
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/linux/sh_pfc.h |    3 ---
 1 file changed, 3 deletions(-)

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
1.7.10.4

