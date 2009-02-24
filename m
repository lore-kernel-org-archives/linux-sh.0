From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 24 Feb 2009 23:45:56 +0000
Subject: Re: [PATCH] pm: rework includes, remove arch ifdefs
Message-Id: <20090224154556.7f4fa1db.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090223080204.13536.67018.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090223080204.13536.67018.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 23 Feb 2009 17:02:04 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> This patch contains the following header file changes:
>  - remove arch ifdefs and asm/suspend.h from linux/suspend.h
>  - add asm/suspend.h to disk.c (for arch_prepare_suspend())
>  - add linux/io.h to swsusp.c (for ioremap())

x86_64 allmodconfig:

In file included from arch/x86/kernel/asm-offsets.c:4:
arch/x86/kernel/asm-offsets_64.c: In function 'main':
arch/x86/kernel/asm-offsets_64.c:109: error: invalid use of undefined type 'struct saved_context'
arch/x86/kernel/asm-offsets_64.c:110: error: invalid use of undefined type 'struct saved_context'
arch/x86/kernel/asm-offsets_64.c:111: error: invalid use of undefined type 'struct saved_context'
arch/x86/kernel/asm-offsets_64.c:112: error: invalid use of undefined type 'struct saved_context'
arch/x86/kernel/asm-offsets_64.c:113: error: invalid use of undefined type 'struct saved_context'

