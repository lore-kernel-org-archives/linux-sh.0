From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 11 Jan 2016 18:41:13 +0000
Subject: [PATCH 2/3] ARM: shmobile: timer: Drop support for Cortex A8
Message-Id: <1452537674-20006-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy
file") removed the DTS for the last shmobile SoC with a Cortex A8 CPU
core (sh7372 aka SH-Mobile AP4).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/timer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index d61014a52b43e205..15fc9db797ea6359 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -52,9 +52,7 @@ void __init shmobile_init_delay(void)
 		if (!of_property_read_u32(np, "clock-frequency", &freq))
 			max_freq = max(max_freq, freq);
 
-		if (of_device_is_compatible(np, "arm,cortex-a8")) {
-			div = 2;
-		} else if (of_device_is_compatible(np, "arm,cortex-a9")) {
+		if (of_device_is_compatible(np, "arm,cortex-a9")) {
 			div = 1;
 		} else if (of_device_is_compatible(np, "arm,cortex-a7") ||
 			 of_device_is_compatible(np, "arm,cortex-a15")) {
-- 
1.9.1

