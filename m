From: takasi-y@ops.dti.ne.jp
Date: Sun, 01 Dec 2013 18:19:13 +0000
Subject: [PATCH 02/11] spi: spi-sh-msiof: round up div to fix freq calculation
Message-Id: <1385921962-19843-2-git-send-email-takasi-y@ops.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
In-Reply-To: <1385921962-19843-1-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Truncation on integer division in sh_msiof_spi_set_clk_regs()
results in insufficient transfer frequency (> max_speed_freq).

For example, source 52MHz, required max 6MHz
 52/6 = 8.6 --> 8, then 1/8 table selected,
and result in 52/8 = 6.5 MHz (>6MHz)

Rounding it up is a simple solution.
 52/6 = 8.6 --> 9, then 1/16 table selected,
and result in 52/16 = 3.25 MHz

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
---
 drivers/spi/spi-sh-msiof.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index c74298c..ac8795f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -152,7 +152,7 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 	size_t k;
 
 	if (!WARN_ON(!spi_hz || !parent_rate))
-		div = parent_rate / spi_hz;
+		div = DIV_ROUND_UP(parent_rate, spi_hz);
 
 	/* TODO: make more fine grained */
 
-- 
1.7.9.5

