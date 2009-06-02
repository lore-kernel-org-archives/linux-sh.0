From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 02 Jun 2009 12:26:25 +0000
Subject: Re: [PATCH] sched: sched_clock() clocksource handling.
Message-Id: <1243945585.23657.5934.camel@twins>
List-Id: <linux-sh.vger.kernel.org>
References: <20090602071718.GA17710@linux-sh.org>
	 <1243927502.23657.5619.camel@twins> <20090602073515.GB17710@linux-sh.org>
	 <1243928495.23657.5642.camel@twins>  <20090602075409.GA19294@linux-sh.org>
In-Reply-To: <20090602075409.GA19294@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Daniel Walker <dwalker@fifo99.com>, Linus Walleij <linus.ml.walleij@gmail.com>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, John Stultz <johnstul@linux.vnet.ibm.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2009-06-02 at 16:54 +0900, Paul Mundt wrote:
> @@ -212,6 +213,7 @@ extern struct clocksource *clock;   /* current clocksource */
>  
>  #define CLOCK_SOURCE_WATCHDOG                  0x10
>  #define CLOCK_SOURCE_VALID_FOR_HRES            0x20
> +#define CLOCK_SOURCE_USE_FOR_SCHED_CLOCK       0x40

One more thing though, as John suggested, this bit might want a proper
comment explaining when a clocksource should and should not set this
bit.
