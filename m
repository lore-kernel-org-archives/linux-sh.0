From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Jun 2013 10:19:25 +0000
Subject: Re: [PATCH] gpio: rcar: fix gpio_rcar_of_table
Message-Id: <201306201219.25744.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201306191750.43755.arnd@arndb.de>
 <20130620005017.GA20643@verge.net.au>
In-Reply-To: <20130620005017.GA20643@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 20 June 2013, Simon Horman wrote:
> 
> On Wed, Jun 19, 2013 at 05:50:43PM +0200, Arnd Bergmann wrote:
> > The device table needs to be terminated with an empty element.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > I've just added this patch on top of the arm-soc next/drivers branch
> > that introduced the build warning.
> 
> Thanks, have you pushed it there or do I need to add it and
> send a pull-request?

I've applied this directly.

	Arnd
