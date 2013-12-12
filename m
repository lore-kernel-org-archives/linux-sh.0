From: Geoff Levand <geoff@infradead.org>
Date: Thu, 12 Dec 2013 00:18:56 +0000
Subject: [PATCH 4/4] sh/kexec: Fix kexec build warning
Message-Id: <594a3d26aac66e9668edc81d7bfb4e801575514f.1386807069.git.geoff@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a cast to a printk argument to suppress a type mismatch compiler warning.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 arch/sh/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 9fea49f..b7e65a8 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -60,7 +60,7 @@ static void kexec_info(struct kimage *image)
 		       i,
 		       (unsigned int)image->segment[i].mem,
 		       (unsigned int)image->segment[i].mem +
-				     image->segment[i].memsz,
+		       (unsigned int)image->segment[i].memsz,
 		       (unsigned int)image->segment[i].memsz);
 	}
 	printk("  start     : 0x%08x\n\n", (unsigned int)image->start);
-- 
1.8.1.2

