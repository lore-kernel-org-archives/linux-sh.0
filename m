From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 13 Jul 2015 06:15:02 +0000
Subject: [PATCH v3 01/04] ARM: shmobile: r8a7779: Generic SMP ops
Message-Id: <20150713061502.25534.94700.sendpatchset@little-apple>
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

Changes since V2:
 - None

 arch/arm/mach-shmobile/setup-r8a7779.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2015-07-13 14:19:04.000000000 +0900
@@ -772,6 +772,7 @@ static const char *r8a7779_compat_dt[] _
 };
 
 DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
+	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= shmobile_init_delay,
 	.init_time	= r8a7779_init_time,
