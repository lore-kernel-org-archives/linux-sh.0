From: Mark Brown <broonie@kernel.org>
Date: Mon, 20 Jan 2014 12:54:36 +0000
Subject: Re: [PATCH] ARM: shmobile: compile drivers/sh for CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <20140120125436.GN17314@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="S4drRqups3dkeHIl"
List-Id: <linux-sh.vger.kernel.org>
References: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-sh@vger.kernel.org


--S4drRqups3dkeHIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2014 at 12:01:00PM +0000, Ben Dooks wrote:
> On 20/01/14 11:47, Mark Brown wrote:

> >I think that just makes things more complicated and isn't adding
> >anything over pm_runtime_enable(), it's just boilerplate code.  In
> >theory essentially every driver running on platforms which don't have
> >explicit management of core IP clocks ought to be calling this since
> >potentially the IP might be deployed on another platform which does have
> >clock management (this does actually happen with things like the
> >DesignWare IPs) and it doesn't do anything like say which clocks are
> >expected to be managed in this way which is another thing that can come
> >up when moving devices between platforms.

> That sounds like a real headache where you have two sets of code
> looking at possibly the same clocks, and behaving differently between
> different platforms.

Yup, it's usually only one set of code on the client side but it's
annoying that platform integrations aren't done consistently in hardware
and that this flows through into software.

> >I'm also struggling to see how it provides any sort of build time
> >protection, it would allow the generation of a warning at runtime at
> >best.

> If you don't have the code it WILL NOT LINK. At the moment it is
> entirely possible to link a kernel which will produce a set of confusing
> errors as drivers fail to initialise at startup.

How will this prevent the code linking?  I would expect the "manage the
clocks via runtime PM" call to be a bit of core code, I wouldn't expect
it to be provided by a specific platform otherwise we're in for fail in
a multiplatform environment.  Besides, if it fails to link there's some
missing Kconfig anyway since randconfig is supposed to work.

> We've already had other people run into the issue where they do not
> know why a driver is failing to work (rcar-thermal is one) as the code
> that was managing the clock for it magically vanished during the
> development cycle.

I agree there's a usability problem here, I just don't think that this
is the best fix for it, I think it's breaking abstractions.

> >As far as I can tell the problem that Ben has seen here is that the
> >platform really, really needs the code for its power domains running to
> >be functional (this doesn't seem unreasonable and may not be related to
> >clocks, this may be required to have the IPs powered up at all).  I'd
> >expect this is something for the platform to sort out rather than
> >something for individual drivers to have to carry code for.

> What's power domains got to do with this? You keep bringing this up
> but the error is purely to do with clock management. The code happens
> to be sitting in the drivers/base/pm directory, but could easily sit
> elsewhere.

What these platforms are saying is esssentially that the clocks are part
of the power domain - they're a fundamental part of getting the IP
available for use so there is no point in managing them separately.
This is where I think the abstraction problem is coming, to me it seems
like the platform isn't successfully ensuring that the code to manage
the power domain is there.  The fact that part of what's missing is the
clocks shouldn't matter to the drivers, in doing things like this the
platform is trying to abstract that detail away from the drivers.

> >If it was going to be drivers carrying code for this I would expect it
> >to be something like providing a list of clocks to be managed along with
> >runtime PM - this would also make the code more widely applicable since
> >it's quite common for the runtime PM callbacks to do nothing more than
> >just enable and disable clocks.

> If we are really saying that bus clocks should not be managed
> by the drivers, then we should just enable this across the whole
> kernel and remove the management from any extant drivers (or make
> it so that any drivers that must manage their bus clocks have a
> call to do so).

Yes, I think that would be a useful way to go since it would factor out
some common code patterns that keep cropping up (as I suggested to you
previously).  It may not just be the main IP clocks that the drivers are
managing like this (some drivers end up managing other clocks at the
same time even if they could be more flexible) so if it was something
drivers could make use of themselves that'd be good.

--S4drRqups3dkeHIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3RyJAAoJELSic+t+oim9cyUP/2/XTc/dPBMnxsdAvFZXH/NV
J0h2RvfqPvCgbROCTsJHvyAYwztKlFlz/S2HHo6MJAuK7CFUPlQ6l1ni/dKOqg45
BzDRHgZeu9csRQj5yX/IGXyBfbNHlNoE/QuahBn59O5GwqGDTlQxOp434oJ1bx9D
Qp4l99AzyYRk2RXnDX5SrvJrOkAED/S54TCUy6x2KdXnvntOauFRTl8kyQxwKFfC
bYNMUns034E8h7lnH9wt3IYzQ59esLsbCaQUB6ptnY42/AW0T0gXrvkS6aXjv4eT
S5+A64o0pl3oRqLQfbTKB1jFTbNzC+jU+d/Il70yfcmjhszvhN/7WJ80ueFu3cN5
tTxp5IK5XL17nmqWw5XJ5xGq76JLSa5rJocr6GJUDz6aeLh4KHYTkEptg8qdjuAK
M1lzAyA6iAs/jzdHpBnd3csnLIsIdbYaYp7VyhR2jylMAZcIK7T4eWR1BWLUC/it
5c/cQtGB8tIKN5pkN9Lv4btku2TBD+cnzmijURwEz7cyhD8T+WRtSAQJBJ2/+iwn
5y2W+g4faVCe05qV4Vh1SCleI20PPYTPcwSn7S3UxH6NPuKKlORJF4WdWfdE1Tn5
mEEx1Fwd2ol3QRYk8UDSMTkEtlc8aAXxC3kF/ctMoxty6EML3al3FgSvoyYuDpo2
eH7fMar78df+I7BwbFDq
=Vv2W
-----END PGP SIGNATURE-----

--S4drRqups3dkeHIl--
