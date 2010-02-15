From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Mon, 15 Feb 2010 08:37:50 +0000
Subject: [PATCH to v2.6.33] sh: Fix cannot booting zImage using
Message-Id: <29ab51dc1002150037i60fb846dt60a739cfddb39d08@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/boot/compressed/misc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index d509a50..5ff6dfc 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -117,7 +117,7 @@ void decompress_kernel(void)
 	output_addr = (CONFIG_MEMORY_START + 0x2000);
 #else
 	output_addr = __pa((unsigned long)&_text+PAGE_SIZE);
-#ifdef CONFIG_29BIT
+#if defined(CONFIG_29BIT) || defined(CONFIG_PMB_FIXED)
 	output_addr |= P2SEG;
 #endif
 #endif
-- 
1.6.6.1
