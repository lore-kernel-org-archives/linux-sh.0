From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Jul 2013 09:17:49 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
Message-Id: <CANqRtoQ_wMvjknOPMCnHLMb_WN7tGCe6avsGkKmPfc-G+KBxhg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874nfp5gz3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nfp5gz3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Mon, Jul 8, 2013 at 5:57 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi Magnus
>
> On Mon, 8 Jul 2013, Magnus Damm wrote:
>
>> Hi Guenandi,
>>
>> On Mon, Jul 8, 2013 at 4:06 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > Hi Magnus
>> >
>> > On Mon, 8 Jul 2013, Magnus Damm wrote:
>> >
>> >> Hi Guennadi,
>> >>
>> >> On Fri, Jul 5, 2013 at 5:41 PM, Guennadi Liakhovetski
>> >> <g.liakhovetski@gmx.de> wrote:
>> >> > On Fri, 5 Jul 2013, Magnus Damm wrote:
>> >> >
>> >> >> Hi Guennadi,
>> >> >>
>> >> >> On Fri, Jul 5, 2013 at 5:38 AM, Guennadi Liakhovetski
>> >> >> <g.liakhovetski@gmx.de> wrote:
>> >> >
>> >> > [snip]
>> >> >
>> >> >> > +       sdhi0: sdhi@ee100000 {
>> >> >> > +               compatible = "renesas,r8a7740-sdhi";
>> >> >> > +               reg = <0 0xee100000 0 0x100>;
>> >> >> > +               interrupt-parent = <&gic>;
>> >> >> > +               interrupts = <0 165 4>;
>> >> >> > +               cap-sd-highspeed;
>> >> >> > +               status = "disabled";
>> >> >> > +       };
>> >> >> > +
>> >> >> > +       sdhi1: sdhi@ee120000 {
>> >> >> > +               compatible = "renesas,r8a7740-sdhi";
>> >> >> > +               reg = <0 0xee120000 0 0x100>;
>> >> >> > +               interrupt-parent = <&gic>;
>> >> >> > +               interrupts = <0 166 4>;
>> >> >> > +               cap-sd-highspeed;
>> >> >> > +               status = "disabled";
>> >> >> > +       };
>> >> >> > +
>> >> >> > +       sdhi2: sdhi@ee140000 {
>> >> >> > +               compatible = "renesas,r8a7740-sdhi";
>> >> >> > +               reg = <0 0xee140000 0 0x100>;
>> >> >> > +               interrupt-parent = <&gic>;
>> >> >> > +               interrupts = <0 167 4>;
>> >> >> > +               cap-sd-highspeed;
>> >> >> > +               status = "disabled";
>> >> >> > +       };
>> >> >>
>> >> >> And now we're here again using "r8a7740" for SDHI on r8a73a4.
>> >> >
>> >> > Would this be ok:
>> >> >
>> >> >                 compatible = "renesas,r8a73a4-sdhi", "renesas,r8a7740-sdhi";
>> >>
>> >> At least it is better. Thanks.
>> >>
>> >> I prefer "renesas,r8a73a4-sdhi" only, but the above is acceptable to
>> >> me as long as we remember to add "renesas,r8a73a4-sdhi" to the SDHI
>> >> driver that keeps old behaviour before updating "renesas,r8a7740-sdhi"
>> >> with features that may break r8a73a4.
>> >
>> > I don't think that would make sense. The whole purpose of adding the
>> > compatible string to DT was to avoid touching the driver _unless_ needed.
>>
>> So instead of using DT to describe hardware we should use it to cut
>> slack from a software implementation point of view?
>
> Sorry, don't understand how this is cutting slack. We do use that string,
> so, DT does describe the hardware. Only I don't understand why we shall
> unconditionally add these strings to the drivers, even when no action
> should be taken there?

Well, at the time of writing the DTS, do you know if action is needed or not?

So using r8a7740 looks to me like it's an assumption about how r8a7740
software support happen to be at some certain point in time. It is not
guaranteed that r8a7740 compatibility would be kept in the future,
basically because we don't know how r8a7740 support is going to
evolve. So it's basically describing a certain software state IMO. I
want it to describe hardware instead.

I would be fine it the string was like this UART example:
compatible = "vendor,16550", "vendor,8250";

In the above example with UART we know that 16550 is backwards
compatible with 8250. So if the 16550 driver happens to be disabled in
the kernel then it should be possible to use the 8250 driver. In this
case the register layout and the documentation should point out that
they are compatible.

As a contrast, I believe the following are true for SDHI
- We have no decent documentation - neither for r8a7740 or r8a73a4
- r8a73a4 is most likely not in a parent-child relation ship with r8a7740

So I prefer not to make any assumptions to avoid future headache.

>> > I.e. unless we do know SDHI on the new SoC has a feature that we want to
>> > support and we know, that all DTs out there contain the required
>> > compatibility string, so, now we can just hook to it in the driver and all
>> > platforms will start using that feature magically. If you anyway want to
>> > add _every_ new SoC compatibility to _every_ related driver, I don't think
>> > using two compatibility strings would make sense.
>>
>> I think you know what I think, and that is using a per-SoC
>> compatibility string is stupid since it has nothing to do with SoC.
>> But if we should go down that route, why don't we do it properly at
>> least?
>>
>> I would like to know how you think the following case should be handled:
>>
>> 1. On r8a73a4 without documentation you introduce the following line in the DTS
>>   compatible = "renesas,r8a73a4-sdhi", "renesas,r8a7740-sdhi";
>>
>> 2. After this you happen to receive documentation about r8a7740 SDHI.
>>
>> 3. You update the SDHI driver with r8a7740 specific new features.
>>
>> 4. r8a73a4 now breaks unless you remember to also add "r8a73a4-sdhi"
>
> Again - how is this different from your proposal? Let's say these SoCs
> have a common feature A (idle-wait) and then you discover a new feature B
> on r8a7740 only. With your proposal we have an entry for r8a73a4 in the
> driver, which does nothing. Now, after updating the driver to handle B on
> r8a7740 you also have to remember to extend your r8a73a4 handling to
> disable B there. So, it is just exactly the same, the only difference is,
> with my approach you first add that r8a73a4 compatibility entry when you
> discover the need, with your approach you already have it there in the
> driver as an empty entry, and you anyway have to update it to disable B,
> when it is discovered.

I'm not sure what you mean with"my proposal", however..

Above I don't understand why you have to extend r8a73a4 handling to
disable B. From my point of view, when you update r8a7740 with feature
B you do it with a feature flag that only applies to r8a7740. When
updating r8a7740 you leave that particular feature flag not set on
r8a73a4. So r8a73a4 does not have to be touched.

/ magnus
