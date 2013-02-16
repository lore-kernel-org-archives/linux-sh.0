From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Sat, 16 Feb 2013 16:58:25 +0000
Subject: Re: [PATCH v5 03/13] mmc: provide a standard MMC device-tree binding parser centrally
Message-Id: <20130216165825.GF1906@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
 <1360941242-18153-4-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1302161613450.20044@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1302161613450.20044@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Markus Pargmann <mpa@pengutronix.de>

Hi Guennadi,

On Sat, Feb 16, 2013 at 04:21:16PM +0100, Guennadi Liakhovetski wrote:
> MMC defines a number of standard DT bindings. Having each driver parse
> them individually adds code redundancy and is error prone. Provide a
> standard function to unify the parsing. After all drivers are converted
> to using it instead of their own parsers, this function can be integrated
> into mmc_alloc_host().
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v5:
> 
> 1. fix an uninitialised variable warning. Note, I don't actually know, 
> whether this will fix the error, reported by the kbuild test robot. None 
> of my compilers reports an error there, at most, I've got a warning with 
> one of them, and, surprisingly, it is gone after this change. 
> Surprisingly, because I only add the bus_width initialisation in the error 
> case - exactly as it actually has to be done. In the success case it is 
> assigned set by the function. But the compiler cannot know that!

Maybe the build robot builds with devicetree disabled? In this case
of_property_read_u32_array expands to a static inline function and the
compiler indeed knows that &bus_width is unitialized. It also knows that
this function always returns an error, so what you did below should
silence the compiler.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
