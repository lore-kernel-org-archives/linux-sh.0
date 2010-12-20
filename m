From: Arnd Hannemann <arnd@arndnet.de>
Date: Mon, 20 Dec 2010 15:53:48 +0000
Subject: [PATCH 3/6 v2] mmc: tmio: disable IRQs early in remove
Message-Id: <1292860431-16195-4-git-send-email-arnd@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
In-Reply-To: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Hannemann <arnd@arndnet.de>

With SDIO IRQ, spurious interrupts are generated on
module unloading.

This patch fixes that by disabling IRQs early.
Tested with a b43-based wireless SDIO card and sh_mobile_sdhi.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/mmc/host/tmio_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 18771b4..37721aa 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -1249,9 +1249,9 @@ static int __devexit tmio_mmc_remove(struct platform_device *dev)
 
 	if (mmc) {
 		struct tmio_mmc_host *host = mmc_priv(mmc);
-		mmc_remove_host(mmc);
 		tmio_mmc_release_dma(host);
 		free_irq(host->irq, host);
+		mmc_remove_host(mmc);
 		if (cell->disable)
 			cell->disable(dev);
 		iounmap(host->ctl);
-- 
1.7.2.3

