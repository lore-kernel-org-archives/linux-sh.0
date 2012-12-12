From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 12 Dec 2012 14:38:13 +0000
Subject: [PATCH 09/14] mmc: sh-mmcif: (cosmetic) simplify boolean return blocks
Message-Id: <1355323098-18061-10-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

Use "return condition" instead of "if (condition) return true; return false"
in functions, returning bool.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index d8d65c0..1a7c602 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -542,10 +542,7 @@ static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
 		host->pio_ptr = p;
 	}
 
-	if (host->sg_idx = data->sg_len)
-		return false;
-
-	return true;
+	return host->sg_idx != data->sg_len;
 }
 
 static void sh_mmcif_single_read(struct sh_mmcif_host *host,
@@ -1071,9 +1068,7 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 
 	if (!host->dma_active) {
 		data->error = sh_mmcif_data_trans(host, host->mrq, cmd->opcode);
-		if (!data->error)
-			return true;
-		return false;
+		return !data->error;
 	}
 
 	/* Running in the IRQ thread, can sleep */
-- 
1.7.2.5

