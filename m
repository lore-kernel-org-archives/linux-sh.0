From: Paul Walmsley <pwalmsley@nvidia.com>
Date: Wed, 27 Nov 2013 00:49:38 +0000
Subject: [PATCH] ARM: shmobile: mackerel: clk_round_rate() can return a zero to indicate an error
Message-Id: <alpine.DEB.2.02.1311261647550.11450@tamien>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Treat both negative and zero return values from clk_round_rate() as
errors.  This is needed since subsequent patches will convert
clk_round_rate()'s return value to be an unsigned type, rather than a
signed type, since some clock sources can generate rates higher than
(2^31)-1 Hz.

Eventually, when calling clk_round_rate(), only a return value of zero
will be considered a error.  All other values will be considered valid
rates.  The comparison against values less than 0 is kept to preserve
the correct behavior in the meantime.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
Applies on v3.13-rc1.  See also:

     http://marc.info/?l=linux-arm-kernel&m8542591313620&w=2

  arch/arm/mach-shmobile/board-mackerel.c |    4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index af06753eb809..d90d2f11071b 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -548,9 +548,9 @@ static void __init hdmi_init_pm_clock(void)
  		 clk_get_rate(&sh7372_pllc2_clk));

  	rate = clk_round_rate(&sh7372_pllc2_clk, 594000000);
-	if (rate < 0) {
+	if (rate <= 0) {
  		pr_err("Cannot get suitable rate: %ld\n", rate);
-		ret = rate;
+		ret = -EINVAL;
  		goto out;
  	}

