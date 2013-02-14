From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Feb 2013 15:55:36 +0000
Subject: Re: [PATCH] gpio: em: Use irq_domain_add_simple() to fix runtime error
Message-Id: <20130214155532.GA25773@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130212155613.13396.44355.sendpatchset@w520>
In-Reply-To: <20130212155613.13396.44355.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2013 at 09:30:12PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Wed, Feb 13, 2013 at 5:11 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Feb 13, 2013 at 12:56:13AM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Adjust the gpio-em.c driver to reconsider the pdata->irq_base
> >> variable. Non-DT board code like for instance board-kzm9d.c
> >> needs to operate of a static IRQ range for platform devices.
> >>
> >> So this patch is updating the code to make use of the function
> >> irq_domain_add_simple() instead of irq_domain_add_linear().
> >>
> >> Fixes a EMEV2 / KZM9D runtime error caused by the following commit:
> >> 7385500 gpio/em: convert to linear IRQ domain
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> >
> > Tested-by: Simon Horman <horms+renesas@verge.net.au>
> > Reported-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > This appears to be a regression between v3.7 and v3.8-rc1 which
> > (possibly amongst other things) prevents the NIC on the KZM9D
> > from functioning.
> 
> Thanks, Simon. I forgot to add you on the Reported-by. Good to see
> that you've tested the patch.
> 
> So how can we merge this one? From my point of view, if v3.8 is
> difficult timing wise then v3.9 is fine.

I assumed it would go through the GIPO tree.
But I can handle it through the renesas tree if
that is preferred.

In any case I guess it should go into v3.9 and 3.8-stable.
