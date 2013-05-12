From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 12 May 2013 20:42:37 +0000
Subject: Re: Build regressions/improvements in v3.10-rc1 (sh)
Message-Id: <alpine.DEB.2.00.1305122241070.5463@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.00.1305122130270.3789@ayla.of.borg> <alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: linux-sh@vger.kernel.org

On Sun, 12 May 2013, Geert Uytterhoeven wrote:
> However, the full list of errors isn't that unmanageable, so I'm following
> up with a digested list...

arch/sh/kernel/kgdb.c:225:32: error: implicit declaration of function 'task_stack_page' [-Werror=implicit-function-declaration]: 3 errors in 3 logs
arch/sh/kernel/kgdb.c:242:23: error: dereferencing pointer to incomplete type: 3 errors in 3 logs
arch/sh/kernel/kgdb.c:243:22: error: dereferencing pointer to incomplete type: 3 errors in 3 logs
arch/sh/kernel/kgdb.c:310:27: error: 'SIGTRAP' undeclared (first use in this function): 3 errors in 3 logs
	v3.10-rc1/sh4/sh-randconfig v3.10-rc1/sh4/sh-allyesconfig v3.10-rc1/sh4/sh-allmodconfig


drivers/net/wireless/libertas/if_cs.c:830:3: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]: 2 errors in 2 logs
drivers/net/wireless/libertas/if_cs.c:882:2: error: implicit declaration of function 'ioport_map' [-Werror=implicit-function-declaration]: 2 errors in 2 logs
drivers/net/wireless/orinoco/orinoco_cs.c:154:2: error: implicit declaration of function 'ioport_map' [-Werror=implicit-function-declaration]: 2 errors in 2 logs
drivers/net/wireless/orinoco/orinoco_cs.c:206:3: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]: 2 errors in 2 logs
drivers/net/wireless/orinoco/spectrum_cs.c:217:2: error: implicit declaration of function 'ioport_map' [-Werror=implicit-function-declaration]: 2 errors in 2 logs
drivers/net/wireless/orinoco/spectrum_cs.c:274:3: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]: 2 errors in 2 logs
	v3.10-rc1/sh4/sh-allyesconfig v3.10-rc1/sh4/sh-allmodconfig

	Missing I/O ops


ERROR: "__ashrdi3" [fs/ntfs/ntfs.ko] undefined!: 1 errors in 1 logs
ERROR: "__ashrdi3" [fs/xfs/xfs.ko] undefined!: 1 errors in 1 logs
	v3.10-rc1/sh4/titan_defconfig

	Missing gcc lib helpers


ERROR: "max_low_pfn" [drivers/block/aoe/aoe.ko] undefined!: 1 errors in 1 logs
ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!: 1 errors in 1 logs
	v3.10-rc1/sh4/titan_defconfig

	Missing export (handle like MIPS?)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
