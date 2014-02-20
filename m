From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Feb 2014 14:43:02 +0000
Subject: [PATCH 03/10] spi: sh-msiof: Change hz from unsigned long to u32
Message-Id: <1392907389-21798-4-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Yoshii <takasi-y@ops.dti.ne.jp>, Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Both spi_transfer.speed_hz and spi_master.max_speed_hz are u32

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-sh-msiof.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index cc12e755131d..af9f2db41b16 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -144,8 +144,7 @@ static struct {
 };
 
 static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
-				      unsigned long parent_rate,
-				      unsigned long spi_hz)
+				      unsigned long parent_rate, u32 spi_hz)
 {
 	unsigned long div = 1024;
 	size_t k;
@@ -372,10 +371,9 @@ static int sh_msiof_spi_bits(struct spi_device *spi, struct spi_transfer *t)
 	return bits;
 }
 
-static unsigned long sh_msiof_spi_hz(struct spi_device *spi,
-				     struct spi_transfer *t)
+static u32 sh_msiof_spi_hz(struct spi_device *spi, struct spi_transfer *t)
 {
-	unsigned long hz;
+	u32 hz;
 
 	hz = t ? t->speed_hz : 0;
 	if (!hz)
-- 
1.7.9.5

