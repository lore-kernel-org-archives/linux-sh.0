From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Dec 2015 08:16:27 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <CAMuHMdUC9P=2VpZQCeKN=NV1Ne2RhE2RumwFabwy7xWe_WXhAw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 15, 2015 at 8:58 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Oct 26, 2015 at 04:08:04AM +0200, Laurent Pinchart wrote:
>> On Saturday 24 October 2015 19:46:11 Geert Uytterhoeven wrote:
>> > On Fri, Oct 23, 2015 at 2:49 PM, Laurent Pinchart wrote:
>> > >> --- a/include/misc/boot-mode-reg.h
>> > >> +++ b/include/misc/boot-mode-reg.h
>> > >> @@ -21,4 +21,7 @@
>> > >>
>> > >>  int boot_mode_reg_get(u32 *mode);
>> > >>  int boot_mode_reg_set(u32 mode);
>> > >>
>> > >> +/* Allow explicit initialisation before initcalls */
>> > >> +int rcar_gen2_init_boot_mode(void);
>> > >> +
>> > >
>> > > I would move this to a separate header file.
>> > >
>> > > And I'd like to also get rid of it :-) Do we need this function for any
>> > > purpose other than arch timer initialization in
>> > > arch/arm/mach-shmobile/setup-rcar-gen2.c ? Quickly looking it that code
>> > > I wonder whether we couldn't get the extal frequency from DT instead of
>> > > the boot mode pins, which would then remove the dependency.
>> >
>> > We do have the extal frequency in DT.
>> >
>> > The boot mode pins does not control the extal frequency, but a few dividers
>> > internal to the CPG.
>>
>> Agreed, but in rcar_gen2_read_mode_pins() it's used to get the external clock
>> frequency as each PLL setting is specific to one external frequency.
>
> I think that Laurent has a good point here and if extal frequency
> was taken from DT then we probably wouldn't need early access to mode pins
> in rcar_gen2_read_mode_pins().

Indeed.

Can we make use of Documentation/devicetree/bindings/arm/arch_timer.txt
for r8a7794?

"- clock-frequency : The frequency of the main counter, in Hz. Should be present
   only where necessary to work around broken firmware which does not configure
   CNTFRQ on all CPUs to a uniform correct value. Use of this property is
   strongly discouraged; fix your firmware unless absolutely impossible."

> However, early access to mode pins is also seems to be required by
> rcar_gen2_cpg_register_clock().

Which is not that early...
Which can easily use the rst node and renesas,modemr?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
