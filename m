From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 06 Jan 2015 10:01:26 +0000
Subject: [PATCH] spi: sh-msiof: fix MDR1_FLD_MASK value
Message-Id: <1420538486-1420-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since the FLD bit field is bit[3:2], the MDR1_FLD_MASK value should
be 0x0000000c.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/spi/spi-sh-msiof.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 96a5fc0..3ab7a21 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -82,7 +82,7 @@ struct sh_msiof_spi_priv {
 #define MDR1_SYNCMD_LR	 0x30000000 /*   L/R mode */
 #define MDR1_SYNCAC_SHIFT	 25 /* Sync Polarity (1 = Active-low) */
 #define MDR1_BITLSB_SHIFT	 24 /* MSB/LSB First (1 = LSB first) */
-#define MDR1_FLD_MASK	 0x000000c0 /* Frame Sync Signal Interval (0-3) */
+#define MDR1_FLD_MASK	 0x0000000c /* Frame Sync Signal Interval (0-3) */
 #define MDR1_FLD_SHIFT		  2
 #define MDR1_XXSTP	 0x00000001 /* Transmission/Reception Stop on FIFO */
 /* TMDR1 */
-- 
1.7.9.5

