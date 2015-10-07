From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 07 Oct 2015 21:42:40 +0000
Subject: Re: [PATCH 1/2] irqchip/renesas-intc-irqpin: Remove obsolete platform data support
Message-Id: <CAMuHMdXXfrD6YkYHOVabM++VoXvW8f2boi3=JkBe3H8CR3=2Lg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444215094-27159-2-git-send-email-geert+renesas@glider.be>
	<201510080222.DOQb22vC%fengguang.wu@intel.com>
In-Reply-To: <201510080222.DOQb22vC%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "kbuild-all@01.org" <kbuild-all@01.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Oct 7, 2015 at 8:51 PM, kbuild test robot <lkp@intel.com> wrote:
> [auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]
>
> config: arm-bockw_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>>> arch/arm/mach-shmobile/setup-r8a7778.c:26:57: fatal error: linux/platform_data/irq-renesas-intc-irqpin.h: No such file or directory
>     #include <linux/platform_data/irq-renesas-intc-irqpin.h>
>                                                             ^

Please ignore. Legacy (non-DT) r8a7778/bockw support has been removed
in arm-soc/for-next.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
