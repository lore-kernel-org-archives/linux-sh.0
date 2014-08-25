From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Aug 2014 12:25:59 +0000
Subject: [PATCH 07/12] mmc: tmio: Make runtime PM callbacks available for CONFIG_PM
Message-Id: <1408969564-6335-8-git-send-email-ulf.hansson@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1408969564-6335-1-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1408969564-6335-1-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

To give the option for tmio hosts to use the runtime PM callbacks for
CONFIG_PM_SLEEP as well as CONFIG_PM_RUNTIME, move them to CONFIG_PM.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc.h     | 2 +-
 drivers/mmc/host/tmio_mmc_pio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index f1ee3e4..2ad52d6 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -149,7 +149,7 @@ int tmio_mmc_host_suspend(struct device *dev);
 int tmio_mmc_host_resume(struct device *dev);
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev);
 int tmio_mmc_host_runtime_resume(struct device *dev);
 #endif
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index d52280d..494ecc5 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1162,7 +1162,7 @@ int tmio_mmc_host_resume(struct device *dev)
 EXPORT_SYMBOL(tmio_mmc_host_resume);
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
-- 
1.9.1

