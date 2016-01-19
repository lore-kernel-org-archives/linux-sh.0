From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 19 Jan 2016 16:20:56 +0000
Subject: [RFC 1/6] mmc: sdhi: Add EXT_ACC register busy check
Message-Id: <1453220461-2598-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

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

