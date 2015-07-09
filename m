From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 09 Jul 2015 00:35:02 +0000
Subject: Re: [PATCH 2/5] i2c: emev2: add binding documentation
Message-Id: <68423578.FklJfiBCEe@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de> <13947160.RNzBrc1uk4@avalon> <20150707195313.GD1572@katana>
In-Reply-To: <20150707195313.GD1572@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

On Tuesday 07 July 2015 21:53:13 Wolfram Sang wrote:
> > > I follow what is done for the other EMEV2 IP cores currently supported.
> > > All cores I checked have PCLK and SCLK but only SCLK is referenced in
> > > the DTS.
> > 
> > Could you briefly explain what the two clocks are for ? Or point me to the
> > right documentation ?
> 
> PCLK is the APB clock. See R19UH0037EJ1200_SMU.pdf, chapter 4.13.

Is that the functional clock, while SCLK is the clock used to control serial 
communication ?

-- 
Regards,

Laurent Pinchart

