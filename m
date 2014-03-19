From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Mar 2014 14:57:49 +0000
Subject: drivers/sh/intc?
Message-Id: <CAMuHMdVBQzgb0eL0YW5r2Da62K-=qNN69RziZxbGe6ZDaaYPwg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

INTC_USERIMASK seems to be the only option in drivers/sh/intc
that may be used on ARCH_SHMOBILE:

config INTC_USERIMASK
        bool "Userspace interrupt masking support"
        depends on ARCH_SHMOBILE || (SUPERH && CPU_SH4A) || COMPILE_TEST
        help
          This enables support for hardware-assisted userspace hardirq
          masking.

          SH-4A and newer interrupt blocks all support a special shadowed
          page with all non-masking registers obscured when mapped in to
          userspace. This is primarily for use by userspace device
          drivers that are using special priority levels.

          If in doubt, say N.

Git history doesn't help much, as the whole Kconfig file was added as one
commit (incremental steps were forgotten).

However, register_intc_userimask() is called from sh4a code only, and
thus never from arm/shmobile code.
So I guess it's safe to remove the dependency?

Furthermore, the core intc parts are used by sh7372/mackerel and
sh73a0/kzm9g (and arch/sh) only, so I'm gonna restrict it to
ARCH_SHMOBILE_LEGACY and SUPERH only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
