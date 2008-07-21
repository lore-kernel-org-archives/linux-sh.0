From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 21 Jul 2008 12:32:28 +0000
Subject: Re: [PATCH] sh7760mmc: driver for SH7760 MMCIF interface.
Message-Id: <20080721123228.GA17848@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080721055030.GA15474@roarinelk.homelinux.net>
In-Reply-To: <20080721055030.GA15474@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 21, 2008 at 09:28:41PM +0900, Paul Mundt wrote:
> On Mon, Jul 21, 2008 at 07:50:31AM +0200, Manuel Lauss wrote:
> > Changes since V1:
> > - rework PIO functions to get rid of P2SEGADDR() macro.
> > - remove mmc host before disabling irqs and peripheral.
> > - stop commands could have other opcodes than '12', account for that.
> > 
> Looks better, but you still forgot the Documentation/ file.

It's gone and the most interesting if its contents are now at the top
of the driver file.

 
> Anyways,
> 
> Acked-by: Paul Mundt <lethal@linux-sh.org>

Thanks.

	Manuel Lauss
