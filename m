From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Jun 2015 08:57:51 +0000
Subject: [PATCH v2 03/06] ARM: shmobile: r8a7779: Generic SMP ops
Message-Id: <20150625085751.24543.2361.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a r8a7779-specific SMP operation pointer to support
all 4 CPU cores through SMP on r8a7779 without C board code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Changes since V1:
 - None

 arch/arm/mach-shmobile/setup-r8a7779.c |    1 +
 1 file changed, 1 insertion(+)

--- 0003/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2015-06-25 17:30:31.232366518 +0900
@@ -772,6 +772,7 @@ static const char *r8a7779_compat_dt[] _
 };
 
 DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
+	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= shmobile_init_delay,
 	.init_time	= r8a7779_init_time,
