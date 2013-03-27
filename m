From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 10:43:39 +0000
Subject: Re: [PATCH 02/02] sh-pfc: Add r8a73a4 GPIO IRQ support
Message-Id: <20130327104144.GA413@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130318145049.26761.35712.sendpatchset@w520>
In-Reply-To: <20130318145049.26761.35712.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 27, 2013 at 11:23:43AM +0100, Linus Walleij wrote:
> On Mon, Mar 18, 2013 at 3:50 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > From: Magnus Damm <damm@opensource.se>
> >
> > Add GPIO -> IRQ mappings to the PFC table for
> > the r8a73a4 SoC. Requires the IRQs to be mapped
> > at a fixed location. The actual IRQs are not
> > handled by the PFC, instead IRQC is used.
> >
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> This will go in with Simon's enormous patch queue I guess?

Yes, that is the plan.
