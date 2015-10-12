From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Oct 2015 07:09:40 +0000
Subject: Re: [PATCH 1/2] irqchip/renesas-intc-irqpin: Remove obsolete platform data support
Message-Id: <CAMuHMdVuib_8ZmBegG899EHdncQXAjPZBcgA_VoBED5ADNuAYQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444215094-27159-2-git-send-email-geert+renesas@glider.be>
	<201510080222.DOQb22vC%fengguang.wu@intel.com>
	<CAMuHMdXXfrD6YkYHOVabM++VoXvW8f2boi3=JkBe3H8CR3=2Lg@mail.gmail.com>
	<alpine.DEB.2.11.1510091415072.6097@nanos>
	<20151012002747.GH20025@verge.net.au>
	<alpine.DEB.2.11.1510120851250.6097@nanos>
In-Reply-To: <alpine.DEB.2.11.1510120851250.6097@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Simon Horman <horms@verge.net.au>, kbuild test robot <lkp@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "kbuild-all@01.org" <kbuild-all@01.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

Hi Thomas,

[CC arnd]

On Mon, Oct 12, 2015 at 8:52 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 12 Oct 2015, Simon Horman wrote:
>> On Fri, Oct 09, 2015 at 02:19:51PM +0200, Thomas Gleixner wrote:
>> > On Wed, 7 Oct 2015, Geert Uytterhoeven wrote:
>> > > On Wed, Oct 7, 2015 at 8:51 PM, kbuild test robot <lkp@intel.com> wrote:
>> > > > [auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]
>> > > >
>> > > > config: arm-bockw_defconfig (attached as .config)
>> > > > reproduce:
>> > > >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>> > > >         chmod +x ~/bin/make.cross
>> > > >         # save the attached .config to linux build tree
>> > > >         make.cross ARCH=arm
>> > > >
>> > > > All errors (new ones prefixed by >>):
>> > > >
>> > > >>> arch/arm/mach-shmobile/setup-r8a7778.c:26:57: fatal error: linux/platform_data/irq-renesas-intc-irqpin.h: No such file or directory
>> > > >     #include <linux/platform_data/irq-renesas-intc-irqpin.h>
>> > > >                                                             ^
>> > >
>> > > Please ignore. Legacy (non-DT) r8a7778/bockw support has been removed
>> > > in arm-soc/for-next.
>> >
>> > That creates a cross tree merge dependency. Bah!
>> >
>> > I have
>> >
>> >   26c21dd9885a: irqchip/renesas-intc-irqpin: r8a7778 IRLM setup support
>> >
>> > in tip irq/core pending. That should not conflict with that one. So I
>> > suggest, that the arm-soc tree carries that cleanup with my
>> >
>> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> >
>> > If you have more changes coming up for irqchip/renesas-intc-irqpin we
>> > probably need to take them through arm-soc as well.
>>
>> I'm happy to take "[PATCH 1/2] irqchip/renesas-intc-irqpin: Remove obsolete
>> platform data support" into the renesas tree with Thomas's ack and forward
>> it to arm-soc for v4.4. Though I will need to finalise doing so in
>> the next few days. I would also be happy to see these patches
>> re-posted once the removal of Legacy (non-DT) r8a7778/bockw support has
>> hit next.
>>
>> Geert, is that your preferred course of action for this patch?
>> And what about "[PATCH 2/2] irqchip/renesas-intc-irqpin: Remove
>> intc_irqpin_priv.number_of_irq"?
>
> If you want to take it now: Acked-by-me
>
> There is also a new one against irqchip/renesas-intc-irqpin from Paul
> Gortmaker, you probably want to pick that up as well.

Thanks for pointing me to those patches, which I had missed.
I think we need a MAINTAINERS entry pointing to linux-sh for those.

But exactly that's why I prefer these removal patches to go through the
subsystem maintainer's tree. This is not about removal of drivers (they
are under active maintenance, and being improved regularly), but about
removing legacy platform support. Handling the platform data removal in
arm-soc opens too many opportunities for merge conflicts.

In fact Arnd was a bit surprised I was waiting on him pulling the legacy
platform removal in arm-soc before sending out the platform device/data
removal patches...

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
