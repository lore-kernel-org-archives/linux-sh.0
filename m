From: Simon Horman <horms@verge.net.au>
Date: Mon, 20 Jun 2011 23:00:11 +0000
Subject: [PATCH 4/5] ARM: mach-shmobile: ag5evm: consistently name sdhi info structures
Message-Id: <1308610812-3479-5-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1308610812-3479-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>, Simon Horman <horms@verge.net.au>

Name the SDHI1 instance sh_sdhi1_info to be consistent with sh_sdhi0_info.

Signed-off-by: Simon Horman <horms@verge.net.au>

---

Dependencies: None known
---
 arch/arm/mach-shmobile/board-ag5evm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 1e2aba2..ce5c251 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -381,7 +381,7 @@ void ag5evm_sdhi1_set_pwr(struct platform_device *pdev, int state)
 	gpio_set_value(GPIO_PORT114, state);
 }
 
-static struct sh_mobile_sdhi_info sh_sdhi1_platdata = {
+static struct sh_mobile_sdhi_info sh_sdhi1_info = {
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
 	.tmio_caps	= MMC_CAP_NONREMOVABLE | MMC_CAP_SDIO_IRQ,
 	.tmio_ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
@@ -413,7 +413,7 @@ static struct platform_device sdhi1_device = {
 	.name		= "sh_mobile_sdhi",
 	.id		= 1,
 	.dev		= {
-		.platform_data	= &sh_sdhi1_platdata,
+		.platform_data	= &sh_sdhi1_info,
 	},
 	.num_resources	= ARRAY_SIZE(sdhi1_resources),
 	.resource	= sdhi1_resources,
-- 
1.7.4.4

