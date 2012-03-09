From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 09 Mar 2012 12:42:22 +0000
Subject: Re: [PATCH v2 0/7] SH Mobile sh_flctl driver brush up
Message-Id: <6053811.8ZSk0nULEX@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
 <1351292.ArCFK2UoQF@avalon> <1331296632.29445.18.camel@sauron.fi.intel.com>
In-Reply-To: <1331296632.29445.18.camel@sauron.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dedekind1@gmail.com
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, linux-mtd@lists.infradead.org, Bastian Hecht <hechtb@googlemail.com>, linux-sh@vger.kernel.org

On Friday 09 March 2012 14:37:12 Artem Bityutskiy wrote:
> On Fri, 2012-03-09 at 13:14 +0100, Laurent Pinchart wrote:
> > ARCH_SHMOBILE is an ARM platform (defined in arch/arm/Kconfig).
> 
> Hmm, ok, thanks. So you say that
> 
> http://www.renesas.eu/products/soc/assp/mobile/sh_mobile/mt1/index.jsp
> 
> saying "CPU core: sh4a" actually means ARM? I must be very confused :-)

Don't trust marketing materiel ;-)

I'm not sure about that exact chip, but the SH-Mobile architecture supported 
by the Linux kernel (and renamed to R-Mobile for recent Renesas products) is 
ARM-based, with an SH-based multimedia coprocessor in most (all ?) models.

-- 
Regards,

Laurent Pinchart

