From: Matt Fleming <mjf@gentoo.org>
Date: Sun, 14 Dec 2008 12:02:28 +0000
Subject: [PATCH 5/5] sh: Enable GENERIC_HARDIRQS_NO__DO_IRQ for all SuperH32 machines
Message-Id: <e4ec8d503ce1f10f5787b0697ee2364c3613fee1.1229255348.git.mjf@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

After the recent changes to switch SuperH board support over to irq_chip
it is now possible to set GENERIC_HARDIRQS_NO__DO_IRQ for all SuperH
boards.

Signed-off-by: Matt Fleming <mjf@gentoo.org>
---
 arch/sh/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index fcfc207..ee22228 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -58,8 +58,7 @@ config GENERIC_HARDIRQS
 
 config GENERIC_HARDIRQS_NO__DO_IRQ
 	def_bool y
-	depends on SUPERH32 && (!SH_DREAMCAST && !SH_SH4202_MICRODEV && \
-				!SH_7751_SYSTEMH)
+	depends on SUPERH32
 
 config GENERIC_IRQ_PROBE
 	def_bool y
-- 
1.5.6.4

