From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 08 Apr 2013 15:20:35 +0000
Subject: Re: [PATCH v6 1/7] media: V4L2: add temporary clock helpers
Message-Id: <5162E043.9050103@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363382873-20077-1-git-send-email-g.liakhovetski@gmx.de>
 <1363382873-20077-2-git-send-email-g.liakhovetski@gmx.de>
 <5147934D.2040908@gmail.com> <Pine.LNX.4.64.1304081234050.29945@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1304081234050.29945@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>

On 04/08/2013 12:36 PM, Guennadi Liakhovetski wrote:
> On Mon, 18 Mar 2013, Sylwester Nawrocki wrote:
> 
> [snip]
> 
>>> +unsigned long v4l2_clk_get_rate(struct v4l2_clk *clk)
>>> +{
>>> +	if (!clk->ops->get_rate)
>>> +		return -ENOSYS;
>>
>> I guess we should just WARN if this callback is null and return 0
>> or return value type of this function needs to be 'long'. Otherwise
>> we'll get insanely large frequency value by casting this error code
>> to unsigned long.
> 
> Comparing to the CCF: AFAICS, they do the same, you're supposed to use 
> IS_ERR_VALUE() on the clock rate, obtained from clk_get_rate().

Hmm, that might work. Nevertheless I consider that a pretty horrible
pattern. I couldn't find any references to IS_ERR_VALUE in the clock
code though. Only that 0 is returned when clk is NULL.

Regards,
Sylwester
