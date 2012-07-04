From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jul 2012 11:05:35 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <Pine.LNX.4.64.1207041258020.21042@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 4 Jul 2012, Mark Brown wrote:

> On Wed, Jul 04, 2012 at 07:41:09PM +0900, Magnus Damm wrote:
> 
> > Right, so what's wrong with having a "select REGULATOR_FIXED_VOLTAGE"
> > on boards that make use of them? That seems to be the most
> > straightforward way to me.
> 
> I tend to agree; as I've said several times now the only sensible
> options I see are:
> 
>  - Add the selects per board.
>  - Just enable the fixed voltage driver whenever the regulator core is
>    enabled.
> 
> Anything else seems silly.
> 
> > Also, I know too little about the regulator subsystem, but to me it is
> > somewhat special that REGULATOR=n behaves differently than REGULATOR=y
> > and REGULATOR_DRIVER=n.
> 
> What's happening is that the regulator API stubs itself out when it's
> not in use in order to avoid having lots of ifdefs every time anyone
> tries to use the API in generic code or drivers that get used on
> multiple platforms.  This is the same behaviour as gpiolib, it's a
> similar sort of utility API.

Right, but there's a difference: the gpio_request() stub in 
include/linux/gpio.h returns -ENOSYS, gpio_is_valid() returns false, etc., 
whereas regulator_get() returns NULL (not an error code), 
regulator_enable() returns 0 (a success...) etc. Yes, I understand, it's a 
design decision and it has its own reasons, but I was a bit surprised when 
I first saw that :)

> If the power on defaults for the system weren't suitable for whatever is
> being done you'd still have an issue even with the stubs but a lot of
> the time the main effect of the API is to allow drivers to do additional
> power optimisations.

Yeah... Which is exactly what produces the difference between REGULATOR=n 
and (REGULATOR=y && REGULATOR_DRIVER=n). But yes, it probably isn't worth 
changing any more, we just have to keep this in mind.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
