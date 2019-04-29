From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 29 Apr 2019 14:33:11 +0000
Subject: [PATCH] sh: exclude vmlinux.scr from .gitignore pattern
Message-Id: <1556548391-14520-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

arch/sh/boot/.gitignore has the pattern "vmlinux*"; this is effective
not only for the current directory, but also for any sub-directories.

So, the following files are also considered to be ignored:

  arch/sh/boot/compressed/vmlinux.scr
  arch/sh/boot/romimage/vmlinux.scr

They are obviously version-controlled, so should be excluded from the
.gitignore pattern.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/boot/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boot/.gitignore b/arch/sh/boot/.gitignore
index 541087d..f50fdd9 100644
--- a/arch/sh/boot/.gitignore
+++ b/arch/sh/boot/.gitignore
@@ -1,3 +1,4 @@
 zImage
 vmlinux*
 uImage*
+!vmlinux.scr
-- 
2.7.4
