From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 18 Sep 2014 19:33:49 +0000
Subject: [PATCH v4] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Message-Id: <10228473.uOqbQ0oioV@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ian.molton@codethink.co.uk, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-sh@vger.kernel.org

I spent a couple of days with the driver just hanging due to me forgetting to
specify the external crystal frequency,  so that clk_get_rate() returned 0 and
thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
acceptable behavior, so I suggest that the minimum frequency is checked for 0
in tmio_mmc_host_probe().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Ian Molton <ian.molton@codethink.co.uk>
Cc: stable@vger.kernel.org

---
The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branch.

Changes in version 4:
- rebased to the 'next' branch, resolving reject;
- added Ian Molton's ACK.

Changes in version 3:
- added Cc: stable.

Changes in version 2:
- fixed grammar in the changelog.

 drivers/mmc/host/tmio_mmc_pio.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: mmc/drivers/mmc/host/tmio_mmc_pio.c
=================================--- mmc.orig/drivers/mmc/host/tmio_mmc_pio.c
+++ mmc/drivers/mmc/host/tmio_mmc_pio.c
@@ -1091,6 +1091,15 @@ int tmio_mmc_host_probe(struct tmio_mmc_
 	}
 
 	/*
+	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
+	 * looping forever...
+	 */
+	if (mmc->f_min = 0) {
+		ret = -EINVAL;
+		goto host_free;
+	}
+
+	/*
 	 * While using internal tmio hardware logic for card detection, we need
 	 * to ensure it stays powered for it to work.
 	 */

