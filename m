From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 25 Jan 2016 19:15:09 +0000
Subject: [PATCH 2/9] mmc: sdhi: Add EXT_ACC register busy check
Message-Id: <1453749316-1848-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

All the docs I have access to say that this register needs the bus busy
check.

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 354f4f335ed57a..61671f3fa09a11 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -163,6 +163,7 @@ static int sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 	case CTL_SD_MEM_CARD_OPT:
 	case CTL_TRANSACTION_CTL:
 	case CTL_DMA_ENABLE:
+	case EXT_ACC:
 		return sh_mobile_sdhi_wait_idle(host);
 	}
 
-- 
2.1.4

