From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 02 Oct 2019 15:47:56 +0000
Subject: [PATCH] sh: kgdb: fix an implicit fallthrough warning
Message-Id: <20191002154756.18924-1-brgl@bgdev.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The switch case in arch/sh/kernel/kgdb.c can fallthrough. Add an
appropriate comment.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/sh/kernel/kgdb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
index 6d61f8cf4c13..0d5f3c9d52f3 100644
--- a/arch/sh/kernel/kgdb.c
+++ b/arch/sh/kernel/kgdb.c
@@ -266,6 +266,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 		ptr = &remcomInBuffer[1];
 		if (kgdb_hex2long(&ptr, &addr))
 			linux_regs->pc = addr;
+		/* fallthrough */
 	case 'D':
 	case 'k':
 		atomic_set(&kgdb_cpu_doing_single_step, -1);
-- 
2.23.0
