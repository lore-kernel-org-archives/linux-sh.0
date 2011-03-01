From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Mar 2011 09:12:25 +0000
Subject: Re: [PATCH] sh: Enable PMB support on SH4AL-DSP
Message-Id: <AANLkTinDugF0o7A4P2sxs120ER0RKddxNaDaD4Wm9SYK@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110301064150.GB5985@linux-sh.org>
In-Reply-To: <20110301064150.GB5985@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 1, 2011 at 6:02 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Mar 01, 2011 at 05:40:41PM +0900, Magnus Damm wrote:
>> On Tue, Mar 1, 2011 at 5:06 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>> > On Tue, Mar 01, 2011 at 05:02:17PM +0900, Magnus Damm wrote:
>> >> sh7722 SH4AL-DSP
>> >> sh7366 SH4AL-DSP
>> >> sh7343 SH4AL-DSP + EXT
>> >> sh7367 SH4AL-DSP + EXT + PMB + BOOT
>> >> sh7377 SH4AL-DSP + EXT + PMB + BOOT
>> >> sh7372 SH4AL-DSP + EXT + PMB + BOOT
>> >>
>> >> EXT = "SH4AL-DSP Extended Functions"
>> >> PMB = "32-bit Address Extended Mode"
>> >> BOOT = "32-bit Boot Function"
>> >>
>> >> From the table it looks like the SH4AL-DSP core can come with and without PMB.
>> >>
>> > That's a pretty special way of interpreting the results.
>> >
>> >> How would you like to special case it?
>> >>
>> > From the above table we see that all SH4AL-DSPs that are standalone cores
>> > have no PMB functionality, and that the only ones that do are in ARM/SH
>> > multi-core configurations. This is what needs to be special cased.
>>
>> So the ARM/SH multi-core configurations with SH4A cores do not?
>>
> I'm not sure how you extracted that question out of the above or even
> what relevance it has to anything.

You seem to want to special case ARM/SH multi-core configurations. I
don't disagree with that, but you are arguing about enabling PMB on
SH4AL-DSP or not. Which I find rather strange, since the PMB may or
may not be included in SH4A.

So the ARM/SH multi-core processors with SH4A does not need this patch.

>> > Implying that the potential existence of the PMB has anything at all to
>> > do with SH4AL-DSP outside of the SH/R-Mobile context is disingenous at
>> > best.
>> > If a standalone SH4AL-DSP pops up with PMB functionality in the future
>> > then of course that can be special cased too, but for now implying that
>> > SH4AL-DSP = PMB is absurd.
>>
>> I'm not implying that. Your logic seems to be inverse somehow. The
>> patch does not imply "SH4AL-DSP = PMB", instead it simply removes the
>> assumption "SH4AL-DSP != PMB". You don't want to allow people to
>> enable PMB on SH4AL-DSP?
>>
> No, I do not want to allow people to enable support for something that
> doesn't exist. Standard SH4AL-DSP parts do not have a PMB, at all,
> period. The only parts with PMBs are regular SH-4A parts and apparently
> all of the SH/R-Mobile multi-core parts regardless of whether they're
> using an SH-4A or SH4AL-DSP based SH core. This is what needs to be
> special cased, and we're not going to pretend like the rest of the
> SH4AL-DSP family can theoretically be equipped with PMB support just
> because a special fork of the SoC line happened to introduce them without
> reving the core version up.

And you're certain that you've seen all SH4AL-DSP parts available?

>> Take a look at sh7723. It has an X2 core and selects CPU_SH4A. People
>> compiling for sh7723 can chose to enable CONFIG_PMB if they want to.
>> This may not be the way you want it to work though, I'm not sure.
>>
> All SH-4A parts support the PMB, so I'm not sure why this is surprising?

sh7723 has an SH4A yes, but no PMB support is included. At least
that's what the data sheet says.

>> But if the sh7723 case is like that then I can't see what is wrong
>> with removing the !SH4AL_DSP bits for the Kconfig.
>>
> Because SH4AL-DSP does not support the PMB. Regular SH-4A cores do, as do
> apparently all of the R-Mobile parts regardless of which core was
> included on the SH SoC side. This is where the special casing needs to
> happen, and I'm not really sure why you seem to be having such a hard
> time following the dependency chain.

I believe that the PMB feature can be added to SH4A or SH4A-DSP,
regardless of if it's included in an ARM multi-core package.

> There are certain things that can be inferred from each core family
> revision. We know that SH-X has a certain subset of features, likewise
> for SH-X2, SH-X3, etc. this is likewise true for SH-4A and SH4AL-DSP. The
> PMB is part of the core features on SH-4A but has never been part of
> SH4AL-DSP. If some hardware people somewhere have taken an SH4AL-DSP and
> bolted on some extra logic to it and made that a standard subset for
> those particular SoCs, then we need to special case the CPU family and
> pile the dependencies on top of that. The pattern as such needs to be one
> of R-Mobile implies PMB rather than SH4AL-DSP implies PMB, as the latter
> is demonstrably false.

But sh7723 is SH-Mobile but it does not support PMB.

> If there are other bits that we know all SH/R-Mobile multicores support,
> then the simplest thing is just to add an R-Mobile family and treat that
> the same way as SH-X3 or the others are handled. We won't be able to make
> any SH-4A or SH4AL-DSP inferences from that, so that will still need to
> be up to the specific CPU subtypes to work out for themselves.
>
> While my expectations are pretty low, the PVR/PRR values should also be
> consulted for all of the PMB-equipped SH/R-Mobile CPUs, as it is possible
> that there's a capability bit that has been set to denote this, or that
> the major rev has gone up so it's possible to do the family assignment
> dynamically at probe time.

That's worth investigating, yes.

/ magnus
