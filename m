From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 13 Nov 2017 10:58:09 +0000
Subject: [PATCH] sh: decompressor: ignore shipped files
Message-Id: <1510570689-30737-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org

These files are copied from arch/sh/lib, so should be ignored by git.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/boot/compressed/.gitignore | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sh/boot/compressed/.gitignore b/arch/sh/boot/compressed/.gitignore
index 2374a83..edff113 100644
--- a/arch/sh/boot/compressed/.gitignore
+++ b/arch/sh/boot/compressed/.gitignore
@@ -1 +1,6 @@
+ashiftrt.S
+ashldi3.c
+ashlsi3.S
+ashrsi3.S
+lshrsi3.S
 vmlinux.bin.*
-- 
2.7.4

