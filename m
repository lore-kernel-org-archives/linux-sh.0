From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 01:18:33 +0000
Subject: [PATCH 11/15] pwm: pwm-renesas-tpu: Enable driver compilation with COMPILE_TEST
Message-Id: <1385515117-23664-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This helps increasing build testing coverage.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index eece329..5de6fcf 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -139,7 +139,7 @@ config PWM_PXA
 
 config PWM_RENESAS_TPU
 	tristate "Renesas TPU PWM support"
-	depends on ARCH_SHMOBILE
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
 	  in Renesas chips through the PWM API.
-- 
1.8.3.2

