From: Simon Horman <horms@verge.net.au>
Date: Sat, 16 Apr 2011 10:38:26 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix Oops during system wake up
Message-Id: <20110416103826.GH16353@verge.net.au>
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

Hi Guennadi,

do you have a link/title for Magnus's patch?

