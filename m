From: Simon Horman <horms@verge.net.au>
Date: Sat, 16 Feb 2013 06:14:34 +0000
Subject: Re: [PATCH] sh-pfc: sh_pfc_probe() sizeof() fix
Message-Id: <20130216061434.GB19142@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130214122347.20778.10789.sendpatchset@w520>
In-Reply-To: <20130214122347.20778.10789.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2013 at 01:27:51PM +0100, Laurent Pinchart wrote:
> On Thursday 14 February 2013 21:23:47 Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Fix sizeof() usage in sh-pfc/core.c to allocate space
> > for the full data structure instead of a pointer.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Forgot to add my
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[snip]

On Fri, Feb 15, 2013 at 08:46:18PM +0100, Linus Walleij wrote:
> On Thu, Feb 14, 2013 at 1:23 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > From: Magnus Damm <damm@opensource.se>
> >
> > Fix sizeof() usage in sh-pfc/core.c to allocate space
> > for the full data structure instead of a pointer.
> >
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>


Thanks. I have added the Acked-by lines and sent a pull-request
to arm-soc to have it included in 3.9.
