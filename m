From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 12 Jun 2016 06:54:22 +0000
Subject: [PATCH v2 04/17] sh: Use P1SEGADDR
Message-Id: <1465714475-24111-5-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

FDT address is P1SEG. So not virtual address.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 86f2792..8e3b099 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -254,7 +254,7 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 #ifdef CONFIG_USE_BUILTIN_DTB
 	dt_virt = __dtb_start;
 #else
-	dt_virt = phys_to_virt(dt_phys);
+	dt_virt = (void *)P1SEGADDR(dt_phys);
 #endif
 
 	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
-- 
2.7.0

