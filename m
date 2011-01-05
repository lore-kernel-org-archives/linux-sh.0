From: Chris Ball <cjb@laptop.org>
Date: Wed, 05 Jan 2011 22:49:10 +0000
Subject: Re: outstanding TMIO MMC patches
Message-Id: <20110105224910.GC13209@void.printf.net>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange> <4D1B3937.80708@arndnet.de> <20110105222408.GM9198@void.printf.net>
In-Reply-To: <20110105222408.GM9198@void.printf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Hannemann <arnd@arndnet.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org

On Wed, Jan 05, 2011 at 10:24:08PM +0000, Chris Ball wrote:
> > There are also these two:
> > 
> > [1/2] tmio_mmc: handle missing HW interrupts
> > 	https://patchwork.kernel.org/patch/201962/
> > [2/2] tmio_mmc: fix CMD irq handling
> > 	https://patchwork.kernel.org/patch/201982/
> 
> I haven't merged these because 1/2 breaks the build without TMIO_MMC_DMA=y.

These two are merged now, was my fault.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
