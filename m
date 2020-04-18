From: Dmitry Safonov <dima@arista.com>
Date: Sat, 18 Apr 2020 20:19:24 +0000
Subject: [PATCHv3 30/50] sh: Remove needless printk()
Message-Id: <20200418201944.482088-31-dima@arista.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200418201944.482088-1-dima@arista.com>
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, Dmitry Safonov <dima@arista.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org

Currently `data' is always an empty line "".
No need for additional printk() call.

Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/kernel/dumpstack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 6784b914fba0..2c1a78e5776b 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -118,7 +118,6 @@ static int print_trace_stack(void *data, char *name)
  */
 static void print_trace_address(void *data, unsigned long addr, int reliable)
 {
-	printk("%s", (char *)data);
 	printk_address(addr, reliable);
 }
 
-- 
2.26.0
