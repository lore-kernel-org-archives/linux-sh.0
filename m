From: Mark Brown <broonie@kernel.org>
Date: Mon, 20 Jan 2014 11:47:05 +0000
Subject: Re: [PATCH] ARM: shmobile: compile drivers/sh for CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <20140120114705.GL17314@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+QmoJrblcRudFCJH"
List-Id: <linux-sh.vger.kernel.org>
References: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-sh@vger.kernel.org


--+QmoJrblcRudFCJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2014 at 10:44:53PM +0100, Laurent Pinchart wrote:
> On Thursday 16 January 2014 17:25:09 Ben Dooks wrote:

> > I was having a think, and how about adding the following to each
> > driver that expects clock management to happen for it, such as the
> > following in the probe sequence:

> > 	pm_runtime_manage_clock(dev);

> > This would mean the following:

> > - People would know a driver had its clock managed elsewhere
> > - You couldn't build a system with the clock_ops disabled.
> > - A system where a mix of drivers where used would work fine
> > - drivers/sh/pm_runtime.c could be deleted too.

> That sounds like a good idea to me. I like how drivers will be responsibl=
e for=20
> explicitly delegating clock handling to generic code. This combines simpl=
icity=20
> with flexibility, and doesn't hide clock handling.

> Mark, Rafael, any opinion ?

I think that just makes things more complicated and isn't adding
anything over pm_runtime_enable(), it's just boilerplate code.  In
theory essentially every driver running on platforms which don't have
explicit management of core IP clocks ought to be calling this since
potentially the IP might be deployed on another platform which does have
clock management (this does actually happen with things like the
DesignWare IPs) and it doesn't do anything like say which clocks are
expected to be managed in this way which is another thing that can come
up when moving devices between platforms.

I'm also struggling to see how it provides any sort of build time
protection, it would allow the generation of a warning at runtime at
best.

As far as I can tell the problem that Ben has seen here is that the
platform really, really needs the code for its power domains running to
be functional (this doesn't seem unreasonable and may not be related to
clocks, this may be required to have the IPs powered up at all).  I'd
expect this is something for the platform to sort out rather than
something for individual drivers to have to carry code for.

If it was going to be drivers carrying code for this I would expect it
to be something like providing a list of clocks to be managed along with
runtime PM - this would also make the code more widely applicable since
it's quite common for the runtime PM callbacks to do nothing more than
just enable and disable clocks.

--+QmoJrblcRudFCJH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3Qy2AAoJELSic+t+oim90AgP+wbZnt+sinMrUTGo+fKH8L3F
8brM/kOjhfSUdNNc52wvd4sJ6+EfFDavdDo3oH0b6Fl0WF7N3QMkZKDw+4yHRNCP
OuvNHaG5PAjlIWrPVblIovNJxXerHPZ/CMZslS/H9wCj58wC/g8r4bIeoMlLe0rN
Mk/RLra46fptByDdj1Z4H0c2GAQ0mSiShENwOYfLpEJVXnD/DamZcIo5zuCxA2BE
haNqByPMwsLXYJAF24BHH+CvIQ0BmXcDhIIaA5ew46Uu09qkwAlkKUslq/VikCV6
a8EljG1uV81G1nnRSzjTvY2vxleFHId+lV5wn8R1O3/+MJWbsMuqJnc4qLvgRICj
1xkBPzJYDEeRIDJShZNwpJfcuIB4P5MPnVaIYk4sJBp5QjDHCEfgXoSW/PrYMzgF
zoIq8PHDQmvkuNlmlgoxvsD8w28j4W9LjvvG8MUlthVy7ruslq3yTcY62R43f/dg
jWFJ3j4DZBp2DCa40mOgEsrCWIusM8lEMEpX8pxCtOU2sYFGTcZF8x99C5hebzkJ
/6ctJwjmQ5g+90GwJzB/4b/VEguE9BF97qSro2u3CZ75AmJSJ0Pg7RTFYKvkxXOu
WgrrauZA9/y9JsMyXj3U8qbSMyP8dod4tK4BSOYc5DJgcphp2rzz9MM5gGWSyWoY
tc5eGsz+mnuSFS7J8gzT
=zqB5
-----END PGP SIGNATURE-----

--+QmoJrblcRudFCJH--
