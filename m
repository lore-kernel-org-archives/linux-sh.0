From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Feb 2014 14:43:01 +0000
Subject: [PATCH 02/10] spi: sh-msiof: Typo in comment s/tx/rx/
Message-Id: <1392907389-21798-3-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Yoshii <takasi-y@ops.dti.ne.jp>, Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-sh-msiof.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index e6f79b2f2616..cc12e755131d 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -486,7 +486,7 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	/* clear status bits */
 	sh_msiof_reset_str(p);
 
-	/* shut down frame, tx/tx and clock signals */
+	/* shut down frame, rx/tx and clock signals */
 	ret = sh_msiof_modify_ctr_wait(p, CTR_TFSE, 0);
 	ret = ret ? ret : sh_msiof_modify_ctr_wait(p, CTR_TXE, 0);
 	if (rx_buf)
-- 
1.7.9.5

