From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Sep 2015 07:26:32 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <CAMuHMdVry-FQteEuMP-5Vj67Dmw17=eNcZr=sfW5k0XDxH7H-g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Sep 2, 2015 at 4:13 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Aug 28, 2015 at 01:51:20PM +0300, Sergei Shtylyov wrote:
>> On 8/28/2015 11:35 AM, Geert Uytterhoeven wrote:
>> >On Fri, Aug 28, 2015 at 10:27 AM, Simon Horman <horms@verge.net.au> wrote:
>> >>--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
>> >>+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
>> >>@@ -6,8 +6,12 @@ interface contains.
>> >>  Required properties:
>> >>  - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
>> >>               "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
>> >>+             "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
>> >>  - reg: offset and length of (1) the register block and (2) the stream buffer.
>> >>-- interrupts: interrupt specifier for the sole interrupt.
>> >>+- interrupts: interrupt specifiers.
>> >>+             One data and one emac interrupt for the R8A7795 SoC;
>>
>>    Data?! What the heck does it mean? :-/
>
> Perhaps it would be better to refer to them as dmac interrupts.
>
> The documentation makes reference to "merged data interrupt", which
> seems to refer to tx and rx interrupts. But this interrupt is also
> used for error and management related interrupts.
>
> I'm all ears with regards to a good name.
>
> With regards to the documentation consistently referring to "E-MAC",
> which you raised elsewhere. Yes I see that too but I'm not sure where
> you are going there. If you would like to tweak the documentation
> or name of the interrupt somehow please spell out your ideas a little
> more clearly.
>
>> >>+             these interrupts must be named.
>> >>+              One named or unnamed data interrupt otherwise.
>> >>  - phy-mode: see ethernet.txt file in the same directory.
>> >>  - phy-handle: see ethernet.txt file in the same directory.
>> >>  - #address-cells: number of address cells for the MDIO bus, must be equal to 1.
>> >>@@ -18,6 +22,12 @@ Required properties:
>> >>  Optional properties:
>> >>  - interrupt-parent: the phandle for the interrupt controller that services
>> >>                     interrupts for this device.
>> >>+- interrupt-names: Names of named interrupts.
>> >>+                   If the property is present "data" is required.
>> >>+                   "emac" is also required for the R8A7795 SoC;
>> >>+                  it is prohibited otherwise.
>> >>+                  This property is mandatory for the R8A7795 SoC;
>> >>+                  optional otherwise.
>> >>  - pinctrl-names: pin configuration state name ("default").
>> >>  - renesas,no-ether-link: boolean, specify when a board does not provide a proper
>> >>                          AVB_LINK signal.
>> >
>> >What about the 25 channel interrupts?
>> >"data" and "emac" seem to use ch22 resp. ch 24 on Gen3.
>> >
>> >I'm afraid this will bite us one day.
>>
>>    Me too. We should describe the real hardware, not how the driver uses it.
>> Where does configuring the AVB interrupt mode happen?
>
> I believe that we all want that. Lets see about making it so :)
>
> As I mentioned above, broadly speaking the interrupts may be configured in
> one of two modes. And the default configuration is to use what I earlier
> described as "compatible". I will now just refer to it as mode 1 with
> the other mode being mode 2.
>
> Mode 1.
>
>   ch22 or ch23 is used for:
>    * Merged Data Interrupts (TX and RX)
>    * Error related interrupts
>    * Management related interrupts
>
>   ch24 is used for:
>    * E-MAC interrupts
>
>   It seems to me that the above basically splits the single interrupt
>   in Gen2 into two.
>
>   This is the default mode for the hardware and the mode it ends up
>   in using the current driver implementation (+ this series which doesn't
>   alter the initialisation of the hardware).
>
> Mode 2.
>
>   ch0 - ch17 are used for:
>   * per-queue Rx interrupts
>
>   ch18 - ch21 are used for:
>   * per-queue Tx interrupts
>
>   ch22 or ch23 are used for:
>   * Other DMA descriptor interrupts (if enabled)
>   * Error related interrupts
>   * Management related interrupts
>
>   ch24 is used for
>   * E-MAC interrupts
>
>
> I think it is instructive to examine differences between the modes for
> Each interrupt. And here is how I see that:
>
>   * ch0 - ch21:
>     mode 1: unused
>     mode 2: per queue rx or tx interrupts
>
>   * ch22 or ch23:
>     both mode 1 and 2:
>     + Error related interrupts
>     + Management related interrupts
>     mode 1 only:
>     + Merged Data Interrupts (TX and RX)
>     mode 2 only:
>     + Other DMA descriptor interrupts (if enabled)
>
>   * ch24:
>     mode 1 and 2: E-MAC interrupts

Thanks for the analysis and the explanation!

> So it seems to me that one possibility would be to:
> * Have names for all of the channels, say rx0 - 18, tx0 - 4, data, dataB, emac.
>   - Better names could be found for data and dataB.

That's one possibility, but it looks to me like the rx* and tx* naming would
be purely a configuration, which doesn't describe the hardware, and perhaps
could even change for future parts? At least having 18 RX channels and 4
TX channels looks arbitrary to me.

> * Allow for properties to describe the mode and possibly which od dataA or B
>   should be used.

Also configuration, not description of the hardware.

> But for now:
> * Only describe the interrupts that are used and default to mode 1 with the
>   data interrupt and;
> * Defer defining properties to switch to combinations
>
> I am all ears for other ideas.

I think there should be either a single multiplexed interrupt (for Gen2),
or a list of named interrupts ("ch%u"), of which ch22/ch23 and ch24 are
mandatory (for Gen3). Other SoCs may reuse the RAVB IP core without
wiring up all channels.

For Gen3, the driver can then choose itself between mode1 and mode2
(if implemented in the driver, and all needed channels are available).

Does this sound sane?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
