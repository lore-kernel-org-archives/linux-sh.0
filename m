From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Sep 2013 23:34:57 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: only enable used I2C interfaces in DT on all Renesas boards
Message-Id: <3980310.JN3jyip2Cv@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309261259490.11968@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309261259490.11968-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Hi Guennadi,

On Thursday 26 September 2013 13:06:01 Guennadi Liakhovetski wrote:
> Currently all I2C interfaces in all *.dtsi files for various Renesas SoCs
> are enabled by default. Switch them all off and only enable populated I2C
> interfaces in board-specific *.dts files.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

I had the exact same patch in my tree, you were faster than me to send it out.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

