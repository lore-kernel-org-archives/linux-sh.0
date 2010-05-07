From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 May 2010 11:24:46 +0000
Subject: Re: [PATCH] sh: modify pinmux for SH7757 2nd cut
Message-Id: <4BE3F87E.90402@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4BE3DC84.4070203@renesas.com>
In-Reply-To: <4BE3DC84.4070203@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Fri, May 07, 2010 at 07:15:31PM +0900, Yoshihiro Shimoda wrote:
>> Paul Mundt wrote:
>>> On Fri, May 07, 2010 at 06:25:24PM +0900, Yoshihiro Shimoda wrote:
>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>> ---
>>>>  arch/sh/include/cpu-sh4/cpu/sh7757.h    |  301 +++---
>>>>  arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c | 1582 ++++++++++++++++++-------------
>>>>  2 files changed, 1081 insertions(+), 802 deletions(-)
>>>>
>>>> diff --git a/arch/sh/include/cpu-sh4/cpu/sh7757.h b/arch/sh/include/cpu-sh4/cpu/sh7757.h
>>>> index f4d267e..15f3de1 100644
>>>> --- a/arch/sh/include/cpu-sh4/cpu/sh7757.h
>>>> +++ b/arch/sh/include/cpu-sh4/cpu/sh7757.h
>>>> @@ -3,241 +3,252 @@
>>>>
>>>>  enum {
>>>>  	/* PTA */
>>>> -	GPIO_PTA7, GPIO_PTA6, GPIO_PTA5, GPIO_PTA4,
>>>> -	GPIO_PTA3, GPIO_PTA2, GPIO_PTA1, GPIO_PTA0,
>>>> +	GPIO_PTA0, GPIO_PTA1, GPIO_PTA2, GPIO_PTA3,
>>>> +	GPIO_PTA4, GPIO_PTA5, GPIO_PTA6, GPIO_PTA7,
>>>>
>>> This looks like the pinout has been completely inverted. Presumably if
>>> this is added then support for the 1st cut will be completely broken?
>>>
>> Yes, I would like to remove the 1st cut supporting because it is prototype CPU.
>>
> We support many prototype CPUs upstream, so this is not an excuse. What
> you are doing is effectively adding a new CPU and simply overloading a
> previous one and screwing over anyone with one of those boards.
> 
> Even after your patches, the old CPU ID matching will still work, meaning
> that anyone with one of those boards will have CPU_SH7757 set when it's
> obvious that the second cut has absolutely nothing in common with the
> first one.
> 
> If the first cut has never made it in to the wild, then I suppose that's
> ok, but if there are already people externally that have these CPUs then
> it's not acceptable to simply break the kernel underneath them on account
> of the hardware people being unable to maintain consistency between
> revisions.
> 
> If the 1st cut has already shipped, then the 2nd cut will have to be
> added as a new CPU by itself. We managed to dodge this bullet for 7786 at
> least by never supporting the 90nm version, but we would have obviously
> been in the same situation there as well of adding a new CPU subtype to
> account for the lack of consistency between silicon revisions.

Thank you very much for your comment.
I will ask my boss about this plan.
Would you wait to apply the today's patches?

Thanks,
Yoshihiro Shimoda

