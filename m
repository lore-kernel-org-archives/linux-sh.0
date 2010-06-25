From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 Jun 2010 08:27:23 +0000
Subject: Re: [PATCH] sh: remove bogus highest / lowest logic from clock rate
Message-Id: <Pine.LNX.4.64.1006250950410.1223@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1006250918150.1223@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1006250918150.1223@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 25 Jun 2010, Paul Mundt wrote:

> On Fri, Jun 25, 2010 at 09:19:39AM +0200, Guennadi Liakhovetski wrote:
> > The use of highest and lowest in clk_rate_table_round() is completely bogus
> > and superfluous. Remove it.
> > 
> In what way is it bogus or superfluous? They are there to provide
> high/low rate bounding when we have no idea what sort of frequencies are
> available for an underlying clock.

Well, firstly initialising lowest to 0 doesn't make sense - there are no 
unsigned integers below it;) It should have been ~0UL. "No idea" you mean 
when the frequency table is empty? But then the highest / lowest checks 
make even less sense - the function would just return 0 ATM. Otherwise 
what they look like they'd have to do, is: in the loop they find max and 
min clock values. If the requested frequency is below min or above max, 
one of them would be used respectively. But that's already done by the 
minimum error check, unless there's a wrap... Am I missing anything?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
