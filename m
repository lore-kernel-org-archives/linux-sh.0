From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 03 May 2012 15:16:01 +0000
Subject: [PATCH/RFC] ARM: sh7372: initialise the GPIO subsystem also when booting with OF
Message-Id: <Pine.LNX.4.64.1205031711270.18111@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh7372_pinmux_init() has to be called during initialisation to make the GPIO
subsystem available.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Goes on top of sh7372 OF patches from Magnus. It might not be what we want 
in the mainline, but it works and was helpful to me. If we do decide to 
include this, feel free to just wrap this into your patch.

 arch/arm/mach-shmobile/setup-sh7372.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index b2378f1..9cdf6c1 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1119,6 +1119,8 @@ void __init sh7372_add_standard_devices_dt(void)
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
+	sh7372_pinmux_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     sh7372_auxdata_lookup, NULL);
 }
-- 
1.7.2.5

