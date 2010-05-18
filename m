From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 May 2010 11:05:44 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.35-rc1
Message-Id: <AANLkTindMQ3Clk_qVnwUNYbbWcXjsUyyy4fQsjdDflFt@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100518092532.GA3050@linux-sh.org>
	 <AANLkTim6t8oG-vdLKE918Sd2TFKJpSf5Bw2PTtSsD_Fh@mail.gmail.com>
	 <20100518101500.GA3156@linux-sh.org>
	 <AANLkTinIVjwrQ9gza2FIvZN5w4nm8ZjSUe836oRmWYG7@mail.gmail.com>
In-Reply-To: <AANLkTinIVjwrQ9gza2FIvZN5w4nm8ZjSUe836oRmWYG7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi Jaswinder,

On Tue, May 18, 2010 at 7:51 PM, Jaswinder Singh Rajput
<jaswinderlinux@gmail.com> wrote:
> Hmm, so still it is between ARM and SH, so better option will be :
>
> include/linux/sh_clk.h -> include/sh/clk.h
> include/linux/sh_dma.h -> include/sh/dma.h
> include/linux/sh_intc.h -> include/sh/intc.h
>
> So when arm files will come then, then we can make it like this :
>
> include/arm/clk.h
> include/arm/dma.h
> include/arm/intc.h
>
> So user will program like this :
>
> #include <arm/dma.h>
> #include <sh/dma.h>

Right now the SH code does

#include <linux/sh_intc.h>

and the ARM code does

#include <linux/sh_intc.h>

Hope this clarifies!

/ magnus
