From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Aug 2014 12:26:00 +0000
Subject: [PATCH 08/12] mmc: sdhi: Make runtime PM callbacks available for CONFIG_PM
Message-Id: <1408969564-6335-9-git-send-email-ulf.hansson@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1408969564-6335-1-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1408969564-6335-1-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

To be able to simplify system PM, let's re-use the runtime PM callbacks
by converting to the SET_PM_RUNTIME_PM_OPS macro.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index be5e25d..4cd0f09 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -333,7 +333,7 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tmio_mmc_host_suspend, tmio_mmc_host_resume)
-	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
+	SET_PM_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
 			tmio_mmc_host_runtime_resume,
 			NULL)
 };
-- 
1.9.1

