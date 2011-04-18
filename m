From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 18 Apr 2011 09:13:37 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix Oops during system wake up
Message-Id: <BANLkTinv6hMsi6BaeUWsrV49Hqq93ogogg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152009080.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152009080.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 18, 2011 at 6:09 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Fri, Apr 15, 2011 at 08:37:55PM +0200, Guennadi Liakhovetski wrote:
>> On Fri, 15 Apr 2011, Guennadi Liakhovetski wrote:
>>
>> > During system resume the clock subsystem is restoring all clock rates,
>> > if sound has not been used before suspend, the rate remains 0 and
>> > the wake up Oopses with division by zero.
>>
>> Right, I see now. Magnus had a more general solution for this problem,
>> which I accidentally dropped in my tests, which caused this Oops. So,
>> maybe his patch to check rate in clks_core_resume() is a better fix for
>> this problem. Feel free to ignore this then.
>>
> Having a solution that doesn't exist in the list archives is effectively
> the same as not having a solution at all.

Sure. I suppose Guennadi is referring to a hunk in a local patch that
doesn't exist in list archives.

> From your description I imagine you mean something like checking if
> clkp->rate is set prior to calling in to ->set_rate, however this
> probably needs a bit more of a think. Your example stipulates that we're
> resuming clocks that haven't been "used", which suggests that we're
> probably better off simply not touching the clock at all in the resume
> path. I expect if you were to set the rate via the recalc path instead it
> also wouldn't have the desired effect for your case.
>
> In any event, it's quite obvious that clks_core_resume() is going to need
> to be reworked a bit.

I ran across this, not sure if it's the right way to fix this.

--- 0001/drivers/sh/clk/core.c
+++ work/drivers/sh/clk/core.c  2011-04-18 08:46:43.000000000 +0900
@@ -641,7 +641,7 @@ static void clks_core_resume(void)
                        if (likely(clkp->ops->set_parent))
                                clkp->ops->set_parent(clkp,
                                        clkp->parent);
-                       if (likely(clkp->ops->set_rate))
+                       if (rate && likely(clkp->ops->set_rate))
                                clkp->ops->set_rate(clkp, rate);
                        else if (likely(clkp->ops->recalc))
                                clkp->rate = clkp->ops->recalc(clkp);

This does not trigger on mainline SH-Mobile ARM since we don't support
system wide suspend.

/ magnus
