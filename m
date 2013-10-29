From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 29 Oct 2013 15:04:40 +0000
Subject: [PATCH 08/10] ARM: shmobile: Let Lager multiplatform boot with Lager DTB
Message-Id: <1383059082-26315-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Let the multiplatform Lager support boot with the legacy DTS for Lager
as well as the Lager reference DTS.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 4d11c0a..bc3d0d2 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -66,6 +66,7 @@ static void __init lager_add_standard_devices(void)
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
+	"renesas,lager",
 	"renesas,lager-reference",
 	NULL,
 };
-- 
1.8.1.5

