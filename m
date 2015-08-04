From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 04 Aug 2015 18:03:06 +0000
Subject: [PATCH 1/7] ARM: shmobile: Remove unused declaration of r8a7778_add_standard_devices_dt()
Message-Id: <1438711392-23763-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The actual implementation was removed by commit 40216263d3d0b9b4 ("ARM:
shmobile: Remove unused r8a7778 auxdata and callback") in v3.12.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/r8a7778.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/r8a7778.h b/arch/arm/mach-shmobile/r8a7778.h
index f64fedb1f2ccb50d..0e77f3f81123a0d3 100644
--- a/arch/arm/mach-shmobile/r8a7778.h
+++ b/arch/arm/mach-shmobile/r8a7778.h
@@ -63,7 +63,6 @@ enum {
 };
 
 extern void r8a7778_add_standard_devices(void);
-extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
-- 
1.9.1

