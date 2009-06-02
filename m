From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 02 Jun 2009 02:49:25 +0000
Subject: [PATCH 3/4] sh7724: add l2_cache_init support
Message-Id: <uab4re4ei.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index ab7f2d9..70fd689 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -578,6 +578,15 @@ void __init plat_early_device_setup(void)
 				   ARRAY_SIZE(sh7724_early_devices));
 }
 
+#define RAMCR_CACHE_L2FC	0x0002
+#define RAMCR_CACHE_L2E		0x0001
+#define L2_CACHE_ENABLE		(RAMCR_CACHE_L2E|RAMCR_CACHE_L2FC)
+void __uses_jump_to_uncached l2_cache_init(void)
+{
+	/* Enable L2 cache */
+	ctrl_outl(L2_CACHE_ENABLE, RAMCR);
+}
+
 enum {
 	UNUSED = 0,
 
-- 
1.6.0.4

