From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 03 May 2014 22:19:29 +0000
Subject: [PATCH] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Message-Id: <201405040219.30018.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ian@mnementh.co.uk, linux-sh@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org

I've spent a couple of days with the driver just hanging due to me forgetting
to specify the external crystal frequency, so that clk_get_rate() returned 0
and thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
acceptable behavior, so I suggest that the minimum frequency is checked for 0
in tmio_mmc_host_probe().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Chris Ball's 'mmc.git' repo's 'master' branch.

 drivers/mmc/host/tmio_mmc_pio.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: mmc/drivers/mmc/host/tmio_mmc_pio.c
=================================--- mmc.orig/drivers/mmc/host/tmio_mmc_pio.c
+++ mmc/drivers/mmc/host/tmio_mmc_pio.c
@@ -1044,6 +1044,15 @@ int tmio_mmc_host_probe(struct tmio_mmc_
 	}
 
 	/*
+	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
+	 * looping forever...
+	 */
+	if (mmc->f_min = 0) {
+		ret = -EINVAL;
+		goto pm_disable;
+	}
+
+	/*
 	 * There are 4 different scenarios for the card detection:
 	 *  1) an external gpio irq handles the cd (best for power savings)
 	 *  2) internal sdhi irq handles the cd
