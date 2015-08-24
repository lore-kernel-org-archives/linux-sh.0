From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 07:51:07 +0000
Subject: Re: [PATCH 3/4 v3][RFC] arm64: renesas: Add initial r8a7795 SoC support
Message-Id: <CAMuHMdXdN4JgjUzLaSwqh61bZ3=NvrPHOW1xWjmyD+f=TLXDfg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877fpdw3av.wl%kuninori.morimoto.gx@renesas.com>
	<12310001.Bt8qbPIiMv@avalon>
	<CAMuHMdWMNLf-fDsiLNFwO05i0cqBHkdM2mwC3GinwWFN4pWFZg@mail.gmail.com>
	<4206643.R1gTHQZqhM@avalon>
In-Reply-To: <4206643.R1gTHQZqhM@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Laurent,

On Thu, Aug 20, 2015 at 9:48 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 20 August 2015 09:43:34 Geert Uytterhoeven wrote:
>> On Wed, Aug 19, 2015 at 11:29 PM, Laurent Pinchart wrote:
>> >> > Also, while you're thinking about the perfect clock binding, please do
>> >> > consider dropping clock-output-names if you can. Specifying clock-names
>> >> > alongside the clocks property inside of the consumer node is a bit more
>> >> > elegant in my opinion. This is also a bit easier if you think about
>> >> > expressing your clock data with C inside of your provider driver.
>> >>
>> >> Makes sense. I don't think anything relies on the "clock-output-names"
>> >> ... currently.
>> >>
>> >> I was going to use it for identifying the GIC clock, though:
>> >>
>> >> --- a/drivers/clk/shmobile/clk-mstp.c
>> >> +++ b/drivers/clk/shmobile/clk-mstp.c
>> >> @@ -144,6 +144,9 @@ cpg_mstp_clock_register(const char *name, const char
>> >> *paren init.name = name;
>> >>
>> >>         init.ops = &cpg_mstp_clock_ops;
>> >>         init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
>> >>
>> >> +       /* INTC-SYS is the module clock of the GIC, and must not be
>> >> disabled */
>> >> +       if (!strcmp(name, "intc-sys"))
>> >> +               init.flags |= CLK_ENABLE_HAND_OFF;
>> >>
>> >>         init.parent_names = &parent_name;
>> >>         init.num_parents = 1;
>> >>
>> >> (FTR, on R-Car Gen3 the clock is called "intc-ap", not "intc-sys",
>> >> doh...).
>> >>
>> >> This does put some reliance on (undocumented) naming in DT, though, so
>> >> not
>> >> having the "clock-output-names" would solve that.
>> >
>> > Using the clock name is indeed very messy, let's avoid that.
>> >
>> >> However, while "intc-sys"/"intc-ap" (if existent) is always MSTP408,
>> >> MSTP408 is used for other modules on R-Car Gen1 and most older SoCs. so
>> >> it would complicate the driver code.
>> >
>> > How about setting the flag based on information provided in DT ?
>>
>> Like scanning DT for the GIC, and looking for its clock?
>>
>> I don't want to add an explicit flag in DT, as it's not a hardware property,
>> but a deficiency of the current GIC driver/subsystem.
>
> What are the changes we can fix the GIC driver in a reasonable time frame ?

Very low.

The GIC driver uses IRQCHIP_DECLARE(), hence it's initialized from
of_irq_init() <- irqchip_init() <- init_IRQ() <- start_kernel().

The MSTP clock driver uses CLK_OF_DECLARE(), hence it's initialized from
of_clk_init() <- time_init() <- start_kernel(), but 7 calls later.

IRQCHIP_DECLARE() doesn't support deferred probing.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvald
