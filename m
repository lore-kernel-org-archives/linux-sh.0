From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 23 Aug 2014 01:44:11 +0000
Subject: [PATCH 01/11] ARM: shmobile: r8a7778: Add missing call to shmobile_init_late()
Message-Id: <54a06dde40f6a01e323d49390d78b8c9f1dfacc0.1408671240.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408671240.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408671240.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add the missing call to shmobile_init_late() to r8a7778_init_late().
This should make sure Suspend-to-RAM and CPUIdle are setup as expected
on bockw.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index f00a488..383e43b 100644
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
2.0.1

