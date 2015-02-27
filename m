From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Feb 2015 10:41:04 +0000
Subject: Re: [PATCH 4/5] ARM: shmobile: Add support SOC_BUS to R-Car Gen2
Message-Id: <CAMuHMdXU6xTNec=82wXuBqh68qt8Amc1mo2c7nGYKDQO=rqTKQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1424931398.git.horms+renesas@verge.net.au>
 <8723510.YP2sm4Z5UY@wuerfel> <20150227005223.GA24717@verge.net.au>
 <2088679.zVJXCDlFW0@wuerfel>
In-Reply-To: <2088679.zVJXCDlFW0@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Fri, Feb 27, 2015 at 10:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 27 February 2015 09:52:23 Simon Horman wrote:
>>
>> On Thu, Feb 26, 2015 at 04:53:39PM +0100, Arnd Bergmann wrote:
>> > On Thursday 26 February 2015 15:22:44 Simon Horman wrote:
>> > > From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> > >
>> > > This provides information through SOC_BUS to sysfs.
>> > > And this moves all on-SoC devices from /sys/devices/platform to
>> > > /sys/devices/socX/.
>> > >
>> > > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> > > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> > > ---
>> > >  arch/arm/mach-shmobile/Kconfig           |  1 +
>> > >  arch/arm/mach-shmobile/setup-rcar-gen2.c | 38 ++++++++++++++++++++++++++++----
>> > >  2 files changed, 35 insertions(+), 4 deletions(-)
>> >
>> > I think this would be better done as a standalone driver in drivers/soc,
>> > to avoid having to add the init_machine callbacks in patch 3.
>>
>> Could we handle this as follow-up work?
>
> That was my first idea when I looked at patch 3, but then I had the other
> comment below:
>

>> > > +     soc_dev_attr->machine = of_flat_dt_get_machine_name();

>> I would not duplicate that information here. Can you find out the SoC
>> name from registers and put it here?
>
> We must not introduce the user interface in one kernel and then change
> it in the next one, so I'm cautious about taking the pull request in
> the current form. Once we have agreed on what the contents of the sysfs
> files should be, I can take the patches, and then we are free to move
> the implementation later.

Currently machine contains e.g. "Koelsch", which is the name of the board,
not of the SoC.

We can derive the SoC name from soc_id, e.g. 0x47 = "R-Car M2-W".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
