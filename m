From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Dec 2015 07:40:23 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <CAMuHMdVLWtiBP3h676qOZTQ=YypP7buSd6hRYrigyMiGs29Q9A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Dec 16, 2015 at 5:32 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Dec 15, 2015 at 09:16:27AM +0100, Geert Uytterhoeven wrote:
>> On Tue, Dec 15, 2015 at 8:58 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Mon, Oct 26, 2015 at 04:08:04AM +0200, Laurent Pinchart wrote:
>> >> On Saturday 24 October 2015 19:46:11 Geert Uytterhoeven wrote:
>> >> > On Fri, Oct 23, 2015 at 2:49 PM, Laurent Pinchart wrote:
>> >> > >> --- a/include/misc/boot-mode-reg.h
>> >> > >> +++ b/include/misc/boot-mode-reg.h
>> >> > >> @@ -21,4 +21,7 @@
>> >> > >>
>> >> > >>  int boot_mode_reg_get(u32 *mode);
>> >> > >>  int boot_mode_reg_set(u32 mode);
>> >> > >>
>> >> > >> +/* Allow explicit initialisation before initcalls */
>> >> > >> +int rcar_gen2_init_boot_mode(void);
>> >> > >> +
>> >> > >
>> >> > > I would move this to a separate header file.
>> >> > >
>> >> > > And I'd like to also get rid of it :-) Do we need this function for any
>> >> > > purpose other than arch timer initialization in
>> >> > > arch/arm/mach-shmobile/setup-rcar-gen2.c ? Quickly looking it that code
>> >> > > I wonder whether we couldn't get the extal frequency from DT instead of
>> >> > > the boot mode pins, which would then remove the dependency.
>> >> >
>> >> > We do have the extal frequency in DT.
>> >> >
>> >> > The boot mode pins does not control the extal frequency, but a few dividers
>> >> > internal to the CPG.
>> >>
>> >> Agreed, but in rcar_gen2_read_mode_pins() it's used to get the external clock
>> >> frequency as each PLL setting is specific to one external frequency.
>> >
>> > I think that Laurent has a good point here and if extal frequency
>> > was taken from DT then we probably wouldn't need early access to mode pins
>> > in rcar_gen2_read_mode_pins().
>>
>> Indeed.
>>
>> Can we make use of Documentation/devicetree/bindings/arm/arch_timer.txt
>> for r8a7794?
>>
>> "- clock-frequency : The frequency of the main counter, in Hz. Should be present
>>    only where necessary to work around broken firmware which does not configure
>>    CNTFRQ on all CPUs to a uniform correct value. Use of this property is
>>    strongly discouraged; fix your firmware unless absolutely impossible."
>>
>> > However, early access to mode pins is also seems to be required by
>> > rcar_gen2_cpg_register_clock().
>>
>> Which is not that early...
>> Which can easily use the rst node and renesas,modemr?
>
> It seems early enough that the initcall to initialise the boot mode pin
> driver would not have kicked in. I can try fiddling the initcall level.
> But I am missing the point?

I meant rcar_gen2_timer_init() runs earlier than rcar_gen2_cpg_clocks_init().

On Gen3, the clocks are initialized much later, as cpg_mssr_init()
uses subsys_initcall(), while Gen2 uses CLK_OF_DECLARE().
We can convert Gen2 to CPG/MSSR, though.

An advantage of using the rst node and renesas,modemr is that all ordering
is resolved automatically, through syscon_regmap_lookup_by_phandle()
and of_syscon_register().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
