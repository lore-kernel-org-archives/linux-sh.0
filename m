From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 01 May 2016 04:59:22 +0000
Subject: [PATCH 12/12] of: Add sh support
Message-Id: <1462078763-27135-13-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1462078763-27135-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1462078763-27135-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kerel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

sh fdt access in VA. But memory reservation use PA.
So sh need convert to PA.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/of/fdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 3349d2a..fb357be 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -593,6 +593,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
 		if (!size)
 			break;
+#ifdef CONFIG_SUPERH
+		base = virt_to_phys(base);
+#endif
 		early_init_dt_reserve_memory_arch(base, size, 0);
 	}
 
-- 
2.7.0

