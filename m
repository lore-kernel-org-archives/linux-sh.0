From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 25 Jun 2010 09:19:14 +0000
Subject: Re: [PATCH] sh: remove bogus highest / lowest logic from clock rate rounding
Message-Id: <20100625091914.GB3133@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1006250918150.1223@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1006250918150.1223@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 25, 2010 at 10:27:23AM +0200, Guennadi Liakhovetski wrote:
> On Fri, 25 Jun 2010, Paul Mundt wrote:
> 
> > On Fri, Jun 25, 2010 at 09:19:39AM +0200, Guennadi Liakhovetski wrote:
> > > The use of highest and lowest in clk_rate_table_round() is completely bogus
> > > and superfluous. Remove it.
> > > 
> > In what way is it bogus or superfluous? They are there to provide
> > high/low rate bounding when we have no idea what sort of frequencies are
> > available for an underlying clock.
> 
> Well, firstly initialising lowest to 0 doesn't make sense - there are no 
> unsigned integers below it;) It should have been ~0UL. "No idea" you mean 
> when the frequency table is empty? But then the highest / lowest checks 
> make even less sense - the function would just return 0 ATM. Otherwise 
> what they look like they'd have to do, is: in the loop they find max and 
> min clock values. If the requested frequency is below min or above max, 
> one of them would be used respectively. But that's already done by the 
> minimum error check, unless there's a wrap... Am I missing anything?
> 
Yes, the lowest initializer is wrong. I suppose we've just been getting
lucky there. The highest/lowest things are used for bounding when probing
the table for the high/low pairs (ie, rounding down from 0xffffffff and
up from 0). I only have a vague memory of writing the code in question
but seem to recall that the rate error calculation itself was not
sufficient for this. Looking at it again though I don't specifically
remember why, so I'll poke at it with your changes and see how it goes.
Given that the lowest thing is already broken it doesn't seem like much
of a stretch to assume that the rate error calculation is already saving
us.
