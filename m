From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 09 Nov 2013 12:33:49 +0000
Subject: [PATCH 2/2] ASoC: sh: rcar: Depend on ARCH_SHMOBILE_LEGACY
Message-Id: <1384000429-3590-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org

The driver doesn't compile on multiplatform kernels as it requires
<mach/clock.h>.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 sound/soc/sh/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 56d8ff6..ce7cfd6 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -36,6 +36,7 @@ config SND_SOC_SH4_SIU
 
 config SND_SOC_RCAR
 	tristate "R-Car series SRU/SCU/SSIU/SSI support"
+	depends on ARCH_SHMOBILE_LEGACY
 	select SND_SIMPLE_CARD
 	select RCAR_CLK_ADG
 	help
-- 
1.8.1.5

