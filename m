From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 06 Nov 2018 18:21:41 +0000
Subject: Re: [PATCH] sh: Provide prototypes for PCI I/O mapping in asm/io.h
Message-Id: <CAMuHMdVYK0SwkTDKrU+bfmCiQ2N5qERuGcqoaXzAsn-aPcCW=w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181106175142.27988-1-broonie@kernel.org>
In-Reply-To: <20181106175142.27988-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Mark,

On Tue, Nov 6, 2018 at 6:52 PM Mark Brown <broonie@kernel.org> wrote:
> Most architectures provide prototypes for the PCI I/O mapping operations
> when asm/io.h is included but SH doesn't currently do that, leading to
> for example warnings in sound/pci/hda/patch_ca0132.c when pci_iomap() is
> used on current -next.  Make SH more consistent with other architectures

Also on v4.20-rc1, cfr.
http://kisskb.ellerman.id.au/kisskb/buildresult/13576888/

> by including asm-generic/pci_iomap.h in asm/io.h.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks for your patch!

> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -24,6 +24,7 @@
>  #define __IO_PREFIX     generic
>  #include <asm/io_generic.h>
>  #include <asm/io_trapped.h>
> +#include <asm-generic/pci_iomap.h>

Is this sufficient?

include/asm-generic/pci_iomap.h provides the dummies if CONFIG_PCI=n and
CONFIG_GENERIC_PCI_IOMAP=y, while arch/sh/Kconfig selects GENERIC_PCI_IOMAP
only if PCI is enabled. Hence it's not set in the failing config
(sh/allyesconfig).

Probably SH should select GENERIC_PCI_IOMAP unconditionally, like most other
architectures do (alpha and powerpc select it conditionally, though)?

>  #include <mach/mangle-port.h>
>
>  #define __raw_writeb(v,a)      (__chk_io_ptr(a), *(volatile u8  __force *)(a) = (v))

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
