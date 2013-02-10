From: Wolfram Sang <w.sang@pengutronix.de>
Date: Sun, 10 Feb 2013 14:53:46 +0000
Subject: Re: [PATCH 0/4] i2c: sh_mobile: fix STOP condition generation
Message-Id: <20130210145346.GA6282@nekote.pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
 <20130124072748.GK8364@nekote.pengutronix.de>
 <Pine.LNX.4.64.1302050942140.1275@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1302050942140.1275-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>


> Thanks, yes, we could try usleep_range(), but these delays could be a bit 
> sensitive, so, such a change would require a new round of testing. Maybe 
> we could commit these patches in this form and then I could try 
> usleep_range() as a separate patch to also make any regression tracking 
> easier?

Sure. So, series applied to for-next, thanks!

