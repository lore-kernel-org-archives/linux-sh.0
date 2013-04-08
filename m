From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Apr 2013 10:36:22 +0000
Subject: Re: [PATCH v6 1/7] media: V4L2: add temporary clock helpers
Message-Id: <Pine.LNX.4.64.1304081234050.29945@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1363382873-20077-1-git-send-email-g.liakhovetski@gmx.de>
 <1363382873-20077-2-git-send-email-g.liakhovetski@gmx.de> <5147934D.2040908@gmail.com>
In-Reply-To: <5147934D.2040908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>

On Mon, 18 Mar 2013, Sylwester Nawrocki wrote:

[snip]

> > +unsigned long v4l2_clk_get_rate(struct v4l2_clk *clk)
> > +{
> > +	if (!clk->ops->get_rate)
> > +		return -ENOSYS;
> 
> I guess we should just WARN if this callback is null and return 0
> or return value type of this function needs to be 'long'. Otherwise
> we'll get insanely large frequency value by casting this error code
> to unsigned long.

Comparing to the CCF: AFAICS, they do the same, you're supposed to use 
IS_ERR_VALUE() on the clock rate, obtained from clk_get_rate().

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
