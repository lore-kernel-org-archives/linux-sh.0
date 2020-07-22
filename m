From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jul 2020 23:52:56 +0000
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-Id: <fa0456c9-cef0-45e7-59d7-ad652734b1d5@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
 <20200722023840.GA55317@roeck-us.net>
 <20200722225239.GX14669@brightrain.aerifal.cx>
In-Reply-To: <20200722225239.GX14669@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Rich,

On 7/22/20 3:52 PM, Rich Felker wrote:
> On Tue, Jul 21, 2020 at 07:38:40PM -0700, Guenter Roeck wrote:
>> On Thu, Dec 12, 2019 at 11:38:43AM +0900, Kuninori Morimoto wrote:
>>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>
>>> __delay() is used from kernel module.
>>> We need EXPORT_SYMBOL(), otherwise we will get compile error.
>>>
>>> ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
>>>
>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> I must admit that this patch completely baffles me. __delay was
>> already exported, only elsewhere in the file. With this patch
>> in place, it is exported twice, and all sh builds in -next fail
>> with
>>
>> In file included from include/linux/linkage.h:7,
>>                  from arch/sh/include/asm/bug.h:5,
>>                  from include/linux/bug.h:5,
>>                  from include/linux/thread_info.h:12,
>>                  from include/asm-generic/current.h:5,
>>                  from ./arch/sh/include/generated/asm/current.h:1,
>>                  from include/linux/sched.h:12,
>>                  from arch/sh/lib/delay.c:8:
>> include/linux/export.h:67:36: error: redefinition of '__ksymtab___delay'
>>
>> Guenter
>>
>>> ---
>>>  arch/sh/lib/delay.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
>>> index dad8e6a..540e670 100644
>>> --- a/arch/sh/lib/delay.c
>>> +++ b/arch/sh/lib/delay.c
>>> @@ -29,6 +29,7 @@ void __delay(unsigned long loops)
>>>  		: "0" (loops)
>>>  		: "t");
>>>  }
>>> +EXPORT_SYMBOL(__delay);
>>>  
>>>  inline void __const_udelay(unsigned long xloops)
>>>  {
> 
> I presently have a revert of this commit in queue for next. If it's
> sufficiently breaking (and especially if there are other regressions
> that need to be fixed, see the pmd_free thing) I could try to get it
> in for 5.8 still but that's getting a bit late.
> 

The patch in mainline is ok. It appears that it has been applied
again in -next.

"git log --oneline v5.7.. arch/sh/lib/delay.c" on top of next-20200721
reports:

ee0e4f15dfd4 (origin/akpm) sh: add missing EXPORT_SYMBOL() for __delay
d1f56f318d23 sh: add missing EXPORT_SYMBOL() for __delay

Maybe it just needs to be dropped from the akpm tree in -next ?

Thanks,
Guenter
