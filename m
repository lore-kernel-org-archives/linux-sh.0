From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 03 Dec 2019 21:36:55 +0000
Subject: Re: [PATCH 0/7] sh: Modernize printing of kernel messages
Message-Id: <20191203213655.GA3253@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20191203162645.19950-1-geert+renesas@glider.be>
In-Reply-To: <20191203162645.19950-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 05:26:38PM +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series fixes the broken lines in kernel output, which I
> presume have been happening since commit 4bcc595ccd80decb ("printk:
> reinstate KERN_CONT for printing continuat ion lines").
> Most annoying are the ones in call traces and disassembly dumps, as they
> cause lots of small bits of information to fly by your serial console.
> 
> Thanks!
> 
> Geert Uytterhoeven (7):
>   sh: kernel: disassemble: Fix broken lines in disassembly dumps
>   sh: dump_stack: Fix broken lines and ptrval in calltrace dumps
>   sh: process: Fix broken lines in register dumps
>   sh: sh2007: Modernize printing of kernel messages
>   sh: pci: Modernize printing of kernel messages
>   sh: machvec: Modernize printing of kernel messages
>   sh: fault: Modernize printing of kernel messages
> 
Yes, the output does look a bit nicer with those patches applied.

For the series:

Tested-by: Guenter Roeck <linux@roeck-us.net>

>  arch/sh/boards/board-sh2007.c    |   4 +-
>  arch/sh/drivers/pci/common.c     |   6 +-
>  arch/sh/drivers/pci/pci-sh7780.c |  23 ++++---
>  arch/sh/drivers/pci/pci.c        |  11 ++--
>  arch/sh/kernel/disassemble.c     | 103 ++++++++++++++++---------------
>  arch/sh/kernel/dumpstack.c       |  24 +++----
>  arch/sh/kernel/machvec.c         |   8 +--
>  arch/sh/kernel/process_32.c      |  38 +++++-------
>  arch/sh/mm/fault.c               |  39 ++++++------
>  9 files changed, 124 insertions(+), 132 deletions(-)
> 
> -- 
> 2.17.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
