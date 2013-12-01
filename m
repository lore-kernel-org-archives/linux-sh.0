From: takasi-y@ops.dti.ne.jp
Date: Sun, 01 Dec 2013 18:19:14 +0000
Subject: [PATCH 03/11] spi: spi-sh-msiof: let it run even without GPIO
Message-Id: <1385921962-19843-3-git-send-email-takasi-y@ops.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
In-Reply-To: <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

In current implementation, CS is controlled by GPIO, which is passed
through spi->controller_data. But because sh-msiof HW module has a
function to output CS by itself, which is already enabled and actual
switch will be done by pinmux, we can silently ignore if GPIO is null.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
---
 drivers/spi/spi-sh-msiof.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index ac8795f..2a2b0dd 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -420,8 +420,10 @@ static void sh_msiof_spi_chipselect(struct spi_device *spi, int is_on)
 					  !!(spi->mode & SPI_LSB_FIRST));
 	}
 
-	/* use spi->controller data for CS (same strategy as spi_gpio) */
-	gpio_set_value((unsigned)spi->controller_data, value);
+	/* use spi->controller data for CS (same strategy as spi_gpio),
+	 * if any. otherwise let HW controll CS */
+	if (spi->controller_data)
+		gpio_set_value((unsigned)spi->controller_data, value);
 
 	if (is_on = BITBANG_CS_INACTIVE) {
 		if (test_and_clear_bit(0, &p->flags)) {
-- 
1.7.9.5

