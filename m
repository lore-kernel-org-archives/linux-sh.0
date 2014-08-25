From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 25 Aug 2014 01:10:12 +0000
Subject: [PATCH 07/10] ARM: shmobile: sh73a0: Use shmobile_init_delay()
Message-Id: <5df622a56b7da3c54609f26cc6221ab3382efaaf.1408927601.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408927601.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408927601.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the sh73a0 SoC support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS. Get rid of the
C code version.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index e7a0296..fe29ebb 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -746,7 +746,7 @@ void __init sh73a0_add_standard_devices(void)
 
 void __init sh73a0_init_delay(void)
 {
-	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
+	shmobile_init_delay();
 }
 
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
-- 
2.0.1

