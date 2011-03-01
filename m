From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Mar 2011 08:40:41 +0000
Subject: Re: [PATCH] sh: Enable PMB support on SH4AL-DSP
Message-Id: <AANLkTikDG_FFkH3C+v6uaqZpaY5KKCHuBNoU5x3R_uwf@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110301064150.GB5985@linux-sh.org>
In-Reply-To: <20110301064150.GB5985@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 1, 2011 at 5:06 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Mar 01, 2011 at 05:02:17PM +0900, Magnus Damm wrote:
>> On Tue, Mar 1, 2011 at 3:41 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>> > On Tue, Mar 01, 2011 at 03:45:14PM +0900, Magnus Damm wrote:
>> >> From: Magnus Damm <damm@opensource.se>
>> >>
>> >> The SH4AL-DSP core included in sh7372 requires use of the PMB,
>> >> update the CONFIG_PMB Kconfig entry to reflect this.
>> >>
>> >> Signed-off-by: Magnus Damm <damm@opensource.se>
>> >
>> > No. SH4AL-DSP does not in general have a PMB. If this CPU subtype is
>> > special, then it needs to be special cased.
>>
>> Well, SH4AL-DSP may not have a PMB in general, but it also may not
>> "not" have it either.
>>
>> This is what I can tell after going through data sheet for a bunch of
>> SH4AL-DSP SoCs:
>>
>> sh7722 SH4AL-DSP
>> sh7366 SH4AL-DSP
>> sh7343 SH4AL-DSP + EXT
>> sh7367 SH4AL-DSP + EXT + PMB + BOOT
>> sh7377 SH4AL-DSP + EXT + PMB + BOOT
>> sh7372 SH4AL-DSP + EXT + PMB + BOOT
>>
>> EXT = "SH4AL-DSP Extended Functions"
>> PMB = "32-bit Address Extended Mode"
>> BOOT = "32-bit Boot Function"
>>
>> From the table it looks like the SH4AL-DSP core can come with and without PMB.
>>
> That's a pretty special way of interpreting the results.
>
>> How would you like to special case it?
>>
> From the above table we see that all SH4AL-DSPs that are standalone cores
> have no PMB functionality, and that the only ones that do are in ARM/SH
> multi-core configurations. This is what needs to be special cased.

So the ARM/SH multi-core configurations with SH4A cores do not?

> Implying that the potential existence of the PMB has anything at all to
> do with SH4AL-DSP outside of the SH/R-Mobile context is disingenous at
> best.
> If a standalone SH4AL-DSP pops up with PMB functionality in the future
> then of course that can be special cased too, but for now implying that
> SH4AL-DSP = PMB is absurd.

I'm not implying that. Your logic seems to be inverse somehow. The
patch does not imply "SH4AL-DSP = PMB", instead it simply removes the
assumption "SH4AL-DSP != PMB". You don't want to allow people to
enable PMB on SH4AL-DSP?

Take a look at sh7723. It has an X2 core and selects CPU_SH4A. People
compiling for sh7723 can chose to enable CONFIG_PMB if they want to.
This may not be the way you want it to work though, I'm not sure.

But if the sh7723 case is like that then I can't see what is wrong
with removing the !SH4AL_DSP bits for the Kconfig.

Or you do want something like SYS_SUPPORTS_PMB?

/ magnus
