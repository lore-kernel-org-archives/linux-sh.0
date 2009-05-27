From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 27 May 2009 06:58:46 +0000
Subject: Re: [PATCH] sched: Support current clocksource handling in
Message-Id: <1243407526.23657.37.camel@twins>
List-Id: <linux-sh.vger.kernel.org>
References: <20090526061532.GD9188@linux-sh.org>
	 <63386a3d0905260731m655bfee3q82a6f52d71fa3cef@mail.gmail.com>
	 <1243348681.23657.14.camel@twins>  <1243369423.3275.5.camel@localhost>
	 <1243369815.6600.2.camel@laptop>  <1243370439.3275.13.camel@localhost>
	 <1243371309.6600.8.camel@laptop>  <1243378835.3275.30.camel@localhost>
In-Reply-To: <1243378835.3275.30.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: john stultz <johnstul@us.ibm.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, John Stultz <johnstul@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, 2009-05-26 at 16:00 -0700, john stultz wrote:

> Sure, I guess what I'm trying to pull out here is that should we try to
> create some OK_FOR_SCHED_CLOCK flag for clocksources, and then we try to
> make this generic so other arches can add that flag and be done, what is
> the guidance we want to give to arch maintainers for setting that flag?
> 
> 1) Has to be very very fast. Can we put a number on this? 50ns to read?

I'd express it in cpu cycles, but not sure, the very fastest the arch
has :-) Just tell people this is in their scheduling hot-path and they
might understand.

> 2) How long does it have to be monotonic for? 

Forever? (per cpu)

> Is it ok if it wraps every few seconds?

No, if it wraps it needs to wrap on u64.

