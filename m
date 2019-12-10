From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Dec 2019 08:39:00 +0000
Subject: [PATCH] sh: kgdb: Mark expected switch fall-throughs
Message-Id: <87muc0y3q4.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87o8wgy3ra.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87o8wgy3ra.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Daniel Thompson <daniel.thompson@linaro.org>, Will Deacon <will@kernel.org>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Mark switch cases where we are expecting to fall through.

This patch fixes the following error:

LINUX/arch/sh/kernel/kgdb.c: In function 'kgdb_arch_handle_exception':
LINUX/arch/sh/kernel/kgdb.c:267:6: error: this statement may fall through [-Werror=implicit-fallthrough=]
if (kgdb_hex2long(&ptr, &addr))
^
LINUX/arch/sh/kernel/kgdb.c:269:2: note: here
case 'D':
^~~~

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/sh/kernel/kgdb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
index 6d61f8c..0d5f3c9 100644
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
2.7.4
