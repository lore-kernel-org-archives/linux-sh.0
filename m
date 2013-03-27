From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 10:47:45 +0000
Subject: Re: [PATCH] gpio: Renesas R-Car GPIO driver V3
Message-Id: <20130327104744.GD3040@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326002301.10878.32801.sendpatchset@w520>
 <2667057.bEM8NUnrg3@avalon>
 <CANqRtoTtJMELH4R9ekAKdaACeqg2vr3mKCqCFKUcdbsq5dqJPA@mail.gmail.com>
In-Reply-To: <CANqRtoTtJMELH4R9ekAKdaACeqg2vr3mKCqCFKUcdbsq5dqJPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca

On Tue, Mar 26, 2013 at 11:16:30PM +0900, Magnus Damm wrote:
> Hi Laurent,
> 
> On Tue, Mar 26, 2013 at 10:03 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > Hi Magnus,
> >
> > Thanks for the patch.
> >
> > On Tuesday 26 March 2013 09:23:01 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> This patch is V3 of a GPIO driver for the R-Car series of
> >> SoCs from Renesas. This driver is designed to be reusable
> >> between multiple SoCs that share the same basic building block,
> >> but so far it has only been used on R-Car H1 (r8a7779).
> 
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > I've taken the patch in my tree.
> 
> That's great, thanks!

And in turn I have added it to the pinmux branch of the renesas tree.
