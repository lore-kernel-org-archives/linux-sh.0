From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 Apr 2011 09:09:21 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix Oops during system wake up
Message-Id: <20110418090921.GE32457@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152009080.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152009080.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 15, 2011 at 08:37:55PM +0200, Guennadi Liakhovetski wrote:
> On Fri, 15 Apr 2011, Guennadi Liakhovetski wrote:
> 
> > During system resume the clock subsystem is restoring all clock rates,
> > if sound has not been used before suspend, the rate remains 0 and
> > the wake up Oopses with division by zero.
> 
> Right, I see now. Magnus had a more general solution for this problem, 
> which I accidentally dropped in my tests, which caused this Oops. So, 
> maybe his patch to check rate in clks_core_resume() is a better fix for 
> this problem. Feel free to ignore this then.
> 
Having a solution that doesn't exist in the list archives is effectively
the same as not having a solution at all.

From your description I imagine you mean something like checking if
clkp->rate is set prior to calling in to ->set_rate, however this
probably needs a bit more of a think. Your example stipulates that we're
resuming clocks that haven't been "used", which suggests that we're
probably better off simply not touching the clock at all in the resume
path. I expect if you were to set the rate via the recalc path instead it
also wouldn't have the desired effect for your case.

In any event, it's quite obvious that clks_core_resume() is going to need
to be reworked a bit.
