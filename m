From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Dec 2010 04:39:47 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0 INTCS support
Message-Id: <20101222043947.GG30700@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101221083732.22944.50364.sendpatchset@t400s>
In-Reply-To: <20101221083732.22944.50364.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 21, 2010 at 05:37:32PM +0900, Magnus Damm wrote:
> Add INTCS support for the sh73a0 processor.
> 
> The interrupts on the sh73a0 processor are managed
> through controllers such as GIC, INTCS and INTCA.
> 
> The ARM cores use the GIC as primary interrupt
> controller and the INTCS and INTCA are hanging off
> the GIC as cascaded interrupt controllers.
> 
> Peripherals connected both to the GIC and the INTC
> controllers should if possible only use the GIC.
> 
> If no GIC connection is available then INTCS and
> INTCA may be used instead.

On Tue, Dec 21, 2010 at 05:40:59PM +0900, Magnus Damm wrote:
> Add support for 2 TMU timer channels on sh73a0.
> 
> One timer channel is used for clocksource and
> the other is used for clockevents. All channels
> in the same TMU block share MSTP bit as usual.

Both applied to rmobile-latest, thanks.
