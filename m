From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Wed, 04 Jul 2018 10:15:46 +0000
Subject: [PATCH 9/9] sh: migor: Remove stale soc_camera include
Message-Id: <1530699346-3235-10-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1530699346-3235-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1530699346-3235-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hverkuil@xs4all.nl, mchehab@kernel.org, ysato@users.sourceforge.jp, dalias@libc.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Remove a stale inclusion for the soc_camera header.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/sh/boards/mach-migor/setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 26543cc..254f2c6 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -28,7 +28,6 @@
 #include <video/sh_mobile_lcdc.h>
 #include <media/drv-intf/renesas-ceu.h>
 #include <media/i2c/ov772x.h>
-#include <media/soc_camera.h>
 #include <media/i2c/tw9910.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
-- 
2.7.4

