From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:30:19 +0000
Subject: Re: [PATCH 01/14] sh: add a temporary macro to define fixed voltage regulators
Message-Id: <Pine.LNX.4.64.1206201725040.20254@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1340205142-32606-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340205142-32606-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 21 Jun 2012, Paul Mundt wrote:

> On Wed, Jun 20, 2012 at 05:12:09PM +0200, Guennadi Liakhovetski wrote:
> > Until the regulator_register_fixed_volt() function becomes available add a
> > macro to define fixed-voltage always on regulators.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Uh, no. If you have a dependency on something in another tree then we
> pull that dependency in to a topic branch and layer on top of that.
> Contrary to popular belief, a couple of changes in a topic branch in
> someone else's tree is hardly a rare occurence, nor does it make you
> special.
> 
> I can't even begin to imagine at what point making this header started to
> look like a good idea, you must really go out of your way to avoid using
> git in your workflow.

Ah, sure, I'd much prefer to use that function directly than to have this 
interim solution. Good, that this is also your preferred way of handling 
this. Will re-send appropriately.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
