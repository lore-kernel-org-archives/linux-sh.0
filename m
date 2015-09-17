From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 06:33:58 +0000
Subject: [PATCH v3 08/09] ARM: shmobile: Prioritize r8a7790 DT APMU support
Message-Id: <20150917063358.26016.8326.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917063240.26016.93772.sendpatchset@little-apple>
In-Reply-To: <20150917063240.26016.93772.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r8a7790 SoC support code to not configure any non-DT SMP code
in case the DT-based enable-method has been installed already.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V2:
 - None

 Changes since V1:
 - New patch.

 arch/arm/mach-shmobile/setup-r8a7790.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2015-08-23 15:44:29.102366518 +0900
@@ -28,6 +28,7 @@ static const char * const r8a7790_boards
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
+	.smp_init	= shmobile_smp_init_fallback_ops,
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
