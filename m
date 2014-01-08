From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 08 Jan 2014 01:33:51 +0000
Subject: [PATCH] mmc: tmio: fixup compile error
Message-Id: <87fvozxnnn.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87iovn8ohs.wl%kuninori.morimoto.gx@renesas.com>
	<87fvqr8ogb.wl%kuninori.morimoto.gx@renesas.com>
	<201401071440.28355.arnd@arndb.de>
In-Reply-To: <201401071440.28355.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch fixup below compile error

${LINUX}/drivers/mmc/host/tmio_mmc.c: In function 'tmio_mmc_probe':
${LINUX}/drivers/mmc/host/tmio_mmc.c:93:35: \
	error: 'res_ctl' undeclared (first use in this function)
${LINUX}/drivers/mmc/host/tmio_mmc.c:93:35: \
	note: each undeclared identifier is reported only \
	once for each function it appears in

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Chris
This is needed on mmc-next branch.

 drivers/mmc/host/tmio_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 8a781e2..1900abb 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -90,7 +90,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
-	pdata->bus_shift = resource_size(res_ctl) >> 10;
+	pdata->bus_shift = resource_size(res) >> 10;
 	pdata->flags |= TMIO_MMC_HAVE_HIGH_REG;
 
 	ret = tmio_mmc_host_probe(&host, pdev, pdata);
-- 
1.7.9.5

