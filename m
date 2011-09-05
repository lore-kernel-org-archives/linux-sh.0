From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 05 Sep 2011 05:06:43 +0000
Subject: Re: Ecovec in current sh-latest
Message-Id: <20110905050642.GF22142@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1109020025350.15166@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1109020025350.15166@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 02, 2011 at 10:17:54AM +0200, Guennadi Liakhovetski wrote:
> To get ecovec to run with today's sh-latest (pretty much the same with 
> Linux' tree) the following patches have to be reverted:
> 
> commit 794d78fea51504bad3880d14f354a9847f318f25
> Author: Magnus Damm <damm@opensource.se>
> Date:   Tue Jun 21 07:55:12 2011 +0000
> 
>     drivers: sh: late disabling of clocks V2
> 
Do we know which driver that's the problem for the ecovec case?

We can of course pile on another CLK_ENABLE_ON_INIT workaround for 3.1,
so long as there's a plan to get the driver properly fixed for 3.2.

> commit 3f9b8520b06013939ad247ba08b69529b5f14be1
> Author: Paul Mundt <lethal@linux-sh.org>
> Date:   Tue May 31 14:38:29 2011 +0900
> 
>     sh64: Move from P1SEG to CAC_ADDR for consistent sync.
> 
I'll queue a revert for this for 3.1. There's quite a bit of bogosity
going on in some of the drivers that this exposed, but we're not going to
get it all fixed in one shot, either.

> commit cb3da5b837a410a1fb90019549b18178f3c87258
> Author: Magnus Damm <damm@opensource.se>
> Date:   Wed Aug 3 12:47:36 2011 +0900
> 
>     serial: sh-sci: console Runtime PM support
> 
What's the issue with this one? I'm assuming this and the clock disabling
revert are related.
