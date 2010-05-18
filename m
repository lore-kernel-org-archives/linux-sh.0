From: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Date: Tue, 18 May 2010 10:51:40 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.35-rc1
Message-Id: <AANLkTinIVjwrQ9gza2FIvZN5w4nm8ZjSUe836oRmWYG7@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100518092532.GA3050@linux-sh.org>
	 <AANLkTim6t8oG-vdLKE918Sd2TFKJpSf5Bw2PTtSsD_Fh@mail.gmail.com>
	 <20100518101500.GA3156@linux-sh.org>
In-Reply-To: <20100518101500.GA3156@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, magnus.damm@gmail.com, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hello Paul,

On Tue, May 18, 2010 at 3:45 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, May 18, 2010 at 03:15:31PM +0530, Jaswinder Singh Rajput wrote:
>> I have few doubts :
>>
>> 1. Which other architectures are using :
>> include/linux/sh_clk.h, include/linux/sh_dma.h and include/linux/sh_intc.h
>>
> ARM for starters, and there are likely to be others in the future, too.
> Grepping would have made this pretty apparent.
>
>> 2. If you think, in future some architecture will going to use these
>> files, then do you think sh_*.h name is appropriate.
>>
> Yes, given that they're all SH IP blocks. Although if there's many more
> of them then of course putting them in their own subdirectory is an
> option, too.
>
>> 3. Can we move :
>> include/linux/sh_clk.h -> drivers/sh/sh_clk.h
>> include/linux/sh_dma.h -> drivers/dma/sh_dma.h
>> include/linux/sh_intc.h -> drivers/sh/sh_intc.h
>> So that if someone want to use these file they can use it from here.
>>
> No.
>
> The alternative is creating a shared architecture directory, which
> doesn't really scale well given how these blocks can be arbitrarily
> reused across different architectures -- but it's still something we
> might have to look at depending on what else pops up that can't be
> cleanly shared through the current scheme. You're of course welcome to
> dig up the discussions in the archives when the ARM SH-Mobile code was
> introduced in the first place.
>

Hmm, so still it is between ARM and SH, so better option will be :

include/linux/sh_clk.h -> include/sh/clk.h
include/linux/sh_dma.h -> include/sh/dma.h
include/linux/sh_intc.h -> include/sh/intc.h

So when arm files will come then, then we can make it like this :

include/arm/clk.h
include/arm/dma.h
include/arm/intc.h

So user will program like this :

#include <arm/dma.h>
#include <sh/dma.h>


There are no doubts in future we will have asymmetrical processing,
where we will use multiple architectures, so better make different
directory for them instead of putting load on include/linux which
already over-loaded.

Thanks,
--
Jaswinder Singh.
