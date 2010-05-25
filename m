From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 May 2010 03:34:20 +0000
Subject: Re: [PATCH] fbdev: fix erroneous index in drivers/video/sh_mobile_lcdcfb.c
Message-Id: <20100525033420.GA2604@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005240949130.2611@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005240949130.2611@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 24, 2010 at 09:53:24AM +0200, Guennadi Liakhovetski wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> This is a fix, so, can go in rc2, no rush. In fact, maybe we can just 
> "continue" on "pdata->ch[i].chan = LCDC_CHAN_DISABLED" in that loop? 
> Doesn't look like anyone is relying on the current behaviour.
> 
>  drivers/video/sh_mobile_lcdcfb.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
That would seem like a reasonable alternative, but I'll let Magnus chime
in incase there's anything expecting that behaviour that hasn't been
merged yet.

Applied, thanks.
