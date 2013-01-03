From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 03 Jan 2013 18:14:17 +0000
Subject: [PATCH] ARM: shmobile: kzm9g: Use of_machine_is_compatible()
Message-Id: <1357236857-12106-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The machine number is hardcoded to ~0 on DT-enabled machines, making
machine_is_*() always fail when support for more than one machine is
compiled into the kernel. Replace the machine_is_kzm9g() call with
of_machine_is_compatible("renesas,kzm9g").

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Without this patch the backlight is never turned on on the kzm9g board if
support for more than one machine is compiled into the kernel.

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index c02448d..eadf309 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -623,7 +623,7 @@ static int __init as3711_enable_lcdc_backlight(void)
 		0x45, 0xf0,
 	};
 
-	if (!machine_is_kzm9g())
+	if (!of_machine_is_compatible("renesas,kzm9g"))
 		return 0;
 
 	if (!a)
-- 
Regards,

Laurent Pinchart

