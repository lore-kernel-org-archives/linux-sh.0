From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Oct 2013 08:12:02 +0000
Subject: [PATCH 02/10] ARM: shmobile: Use r8a7791_add_standard_devices() on Koelsch
Message-Id: <20131001081202.4136.63858.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131001081143.4136.46925.sendpatchset@w520>
In-Reply-To: <20131001081143.4136.46925.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use r8a7791_add_standard_devices() on Koelsch to let
the C version of the board code add on-chip devices.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-10-01 16:25:46.000000000 +0900
@@ -29,7 +29,7 @@
 static void __init koelsch_add_standard_devices(void)
 {
 	r8a7791_clock_init();
-	r8a7791_add_dt_devices();
+	r8a7791_add_standard_devices();
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
