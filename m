From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 13 Aug 2014 11:45:00 +0000
Subject: [PATCH] ARM: shmobile: r8a7778: Add missing call to shmobile_init_late()
Message-Id: <1407930300-10988-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the missing call to shmobile_init_late() to r8a7778_init_late().
This should make sure Suspend-to-RAM and CPUIdle are setup as expected
on bockw.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested

 arch/arm/mach-shmobile/setup-r8a7778.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 7b20b53e92e2..e1a477bce447 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -520,6 +520,7 @@ void __init r8a7778_add_standard_devices(void)
 
 void __init r8a7778_init_late(void)
 {
+	shmobile_init_late();
 	platform_device_register_full(&ehci_info);
 	platform_device_register_full(&ohci_info);
 }
-- 
1.9.1

