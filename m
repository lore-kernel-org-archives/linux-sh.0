From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Sep 2015 08:41:31 +0000
Subject: Re: [PATCH/RFC v2 net-next 3/4] ravb: Document binding for r8a7795 SoC
Message-Id: <CAMuHMdUYhUrT9vBtfPOdDWxHDq+ENhKvg9bmsHZsyyDJ=YtcLw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441936878-18290-1-git-send-email-horms+renesas@verge.net.au>
 <1441936878-18290-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWY+8Cv9ZnnzMcSYskFfArues8EnWgMiCMnQ16sN1TW_A@mail.gmail.com>
 <20150911081443.GD2835@verge.net.au>
In-Reply-To: <20150911081443.GD2835@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Fri, Sep 11, 2015 at 10:14 AM, Simon Horman <horms@verge.net.au> wrote:
>> > @@ -18,6 +21,9 @@ Required properties:
>> >  Optional properties:
>> >  - interrupt-parent: the phandle for the interrupt controller that services
>> >                     interrupts for this device.
>> > +- interrupt-names: One entry per interrupt named "ch%u".
>> > +                  For the R8A7795 SoC this property is mandatory,
>> > +                  and "ch0" through "ch24" are mandatory.
>>
>> This suggests the single multiplexed interrupt on R-Car Gen2 can be called
>> "ch0". Is that what you want? I know the driver doesn't care.
>
> No, its not what I intended.
>
> I think its reasonable to allow the multiplexed interrupt to be named,
> but to what I wonder. The documentation seems to call the interrupt
> "EthernetAVB", which isn't very exciting.

Perhaps "mux", like I did for rspi, cfr.
Documentation/devicetree/bindings/spi/spi-rspi.txt:

  - interrupts       : A list of interrupt-specifiers, one for each entry in
                       interrupt-names.
                       If interrupt-names is not present, an interrupt specifier
                       for a single muxed interrupt.
  - interrupt-names  : A list of interrupt names. Should contain (if present):
                         - "error" for SPEI,
                         - "rx" for SPRI,
                         - "tx" to SPTI,
                         - "mux" for a single muxed interrupt.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
