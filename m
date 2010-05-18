From: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Date: Tue, 18 May 2010 11:28:12 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.35-rc1
Message-Id: <AANLkTilNQwo1YYT2pNJN5X0ae98iMKCdsBkcogjKZm-f@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100518092532.GA3050@linux-sh.org>
	 <AANLkTim6t8oG-vdLKE918Sd2TFKJpSf5Bw2PTtSsD_Fh@mail.gmail.com>
	 <20100518101500.GA3156@linux-sh.org>
	 <AANLkTinIVjwrQ9gza2FIvZN5w4nm8ZjSUe836oRmWYG7@mail.gmail.com>
	 <AANLkTindMQ3Clk_qVnwUNYbbWcXjsUyyy4fQsjdDflFt@mail.gmail.com>
In-Reply-To: <AANLkTindMQ3Clk_qVnwUNYbbWcXjsUyyy4fQsjdDflFt@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hello magnus,

On Tue, May 18, 2010 at 4:35 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi Jaswinder,
>
> On Tue, May 18, 2010 at 7:51 PM, Jaswinder Singh Rajput
> <jaswinderlinux@gmail.com> wrote:
>> Hmm, so still it is between ARM and SH, so better option will be :
>>
>> include/linux/sh_clk.h -> include/sh/clk.h
>> include/linux/sh_dma.h -> include/sh/dma.h
>> include/linux/sh_intc.h -> include/sh/intc.h
>>
>> So when arm files will come then, then we can make it like this :
>>
>> include/arm/clk.h
>> include/arm/dma.h
>> include/arm/intc.h
>>
>> So user will program like this :
>>
>> #include <arm/dma.h>
>> #include <sh/dma.h>
>
> Right now the SH code does
>
> #include <linux/sh_intc.h>
>
> and the ARM code does
>
> #include <linux/sh_intc.h>
>
> Hope this clarifies!
>

I am looking at the future, where multiple architecture will use each
other files.

I am just worried about the file count. Currently :

$ ls include/linux/ | wc -l
1029

If other architecture will also start adding the files in
include/linux like you did then ?

So better make another directory in include.

Thanks,
--
Jaswinder Singh.
