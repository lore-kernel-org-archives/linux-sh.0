From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 16 Jan 2014 22:24:56 +0000
Subject: Re: [PATCH] sh: kgdb: Add missing #include <linux/sched.h>
Message-Id: <20140116222456.GA6723@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389910800-13083-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1389910800-13083-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

On Thu, Jan 16, 2014 at 11:20:00PM +0100, Geert Uytterhoeven wrote:
> From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> 
> arch/sh/kernel/kgdb.c: In function 'sleeping_thread_to_gdb_regs':
> arch/sh/kernel/kgdb.c:225:32: error: implicit declaration of function 'task_stack_page' [-Werror=implicit-function-declaration]
> arch/sh/kernel/kgdb.c:242:23: error: dereferencing pointer to incomplete type
> arch/sh/kernel/kgdb.c:243:22: error: dereferencing pointer to incomplete type
> arch/sh/kernel/kgdb.c: In function 'singlestep_trap_handler':
> arch/sh/kernel/kgdb.c:310:27: error: 'SIGTRAP' undeclared (first use in this function)
> arch/sh/kernel/kgdb.c:310:27: note: each undeclared identifier is reported only once for each function it appears in
> 
> This is introduced by commit 16559ae48c76f1ceb970b9719dea62b77eb5d06b
> ("kgdb: remove #include <linux/serial_8250.h> from kgdb.h").

Which showed up in 3.9-rc1, seems that no one seems to care about this
arch/config much :)

> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> [geert: Reworded and reformatted]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Cc: stable <stable@vger.kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

