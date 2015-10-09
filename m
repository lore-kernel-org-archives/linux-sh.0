From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 09 Oct 2015 12:19:51 +0000
Subject: Re: [PATCH 1/2] irqchip/renesas-intc-irqpin: Remove obsolete platform data support
Message-Id: <alpine.DEB.2.11.1510091415072.6097@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <1444215094-27159-2-git-send-email-geert+renesas@glider.be> <201510080222.DOQb22vC%fengguang.wu@intel.com> <CAMuHMdXXfrD6YkYHOVabM++VoXvW8f2boi3=JkBe3H8CR3=2Lg@mail.gmail.com>
In-Reply-To: <CAMuHMdXXfrD6YkYHOVabM++VoXvW8f2boi3=JkBe3H8CR3=2Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kbuild test robot <lkp@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "kbuild-all@01.org" <kbuild-all@01.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, 7 Oct 2015, Geert Uytterhoeven wrote:
> On Wed, Oct 7, 2015 at 8:51 PM, kbuild test robot <lkp@intel.com> wrote:
> > [auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]
> >
> > config: arm-bockw_defconfig (attached as .config)
> > reproduce:
> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=arm
> >
> > All errors (new ones prefixed by >>):
> >
> >>> arch/arm/mach-shmobile/setup-r8a7778.c:26:57: fatal error: linux/platform_data/irq-renesas-intc-irqpin.h: No such file or directory
> >     #include <linux/platform_data/irq-renesas-intc-irqpin.h>
> >                                                             ^
> 
> Please ignore. Legacy (non-DT) r8a7778/bockw support has been removed
> in arm-soc/for-next.

That creates a cross tree merge dependency. Bah!

I have

  26c21dd9885a: irqchip/renesas-intc-irqpin: r8a7778 IRLM setup support

in tip irq/core pending. That should not conflict with that one. So I
suggest, that the arm-soc tree carries that cleanup with my

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

If you have more changes coming up for irqchip/renesas-intc-irqpin we
probably need to take them through arm-soc as well.

Thanks,

	tglx
