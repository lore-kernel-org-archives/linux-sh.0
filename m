From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 23 Jul 2019 11:30:36 +0000
Subject: [PATCH] sh: remove unneeded uapi asm-generic wrappers
Message-Id: <20190723113036.14576-1-yamada.masahiro@socionext.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, linux-kernel@vger.kernel.org

These are listed in include/uapi/asm-generic/Kbuild, so Kbuild will
automatically generate them.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/include/uapi/asm/setup.h | 2 --
 arch/sh/include/uapi/asm/types.h | 2 --
 2 files changed, 4 deletions(-)
 delete mode 100644 arch/sh/include/uapi/asm/setup.h
 delete mode 100644 arch/sh/include/uapi/asm/types.h

diff --git a/arch/sh/include/uapi/asm/setup.h b/arch/sh/include/uapi/asm/setup.h
deleted file mode 100644
index 4bd19f80f9b0..000000000000
--- a/arch/sh/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/setup.h>
diff --git a/arch/sh/include/uapi/asm/types.h b/arch/sh/include/uapi/asm/types.h
deleted file mode 100644
index 68100e108ea6..000000000000
--- a/arch/sh/include/uapi/asm/types.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/types.h>
-- 
2.17.1
