From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2013 16:28:54 +0000
Subject: Re: [PATCH v3] iommu: shmobile: Enable the driver on all ARM platforms
Message-Id: <20131030162854.GB2493@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="b5gNqxB1S1yM7hjW"
List-Id: <linux-sh.vger.kernel.org>
References: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131030112625.GZ16735@n2100.arm.linux.org.uk>
 <1652955.Gs3XDiEUHO@avalon>
In-Reply-To: <1652955.Gs3XDiEUHO@avalon>
To: linux-arm-kernel@lists.infradead.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2013 at 12:40:12PM +0100, Laurent Pinchart wrote:

> > For similar reasons as x86, can we please think about using:

> > 	depends on ARM
> > 	depends on ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI || COMPILE_TEST

> I'm fine with your proposed option. As I don't want to respin the series=
=20
> dozens of time let's first agree on the course of action, I will then rep=
ost=20
> the patches. Mark, you've pushed towards as few platform dependencies as=
=20
> possible, what's your opinion on this ?

In general I think we should have whatever the real depedencies are or
COMPILE_TEST (to the extent that they will actually build cleanly on
other targets).  That way only people who explicitly go looking to
compile test things for build coverage (eg, when doing global cleanups
or API updates) need to be bothered by the extra compile test options.

I'd read the above as saying the code needs ARM to build at all and that
the hardware will only ever appear on SHMOBILE.

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScTPDAAoJELSic+t+oim9J7cP+gK0uw408e47tOZTXUwEsb8o
Jqrji3lBVL3Zy3CT1ZHrkn726Vuo8+LSJpXqNURFTLp0fhgO9az1S7+hQDBES8R5
3bYafuypgwoltk3pk3gnOucq+wWrn+23QLM9sfVwB19IYKoFeugrXYkrDa4fsV5M
uuhaHLxZMPovzs/OrUSa7SjCHrInhWYKKJOO/OK+3Z+1L24XtAZCDX6/8Nx9bir4
/kMPfP4/G9wAXvU5DaJL10kWNnFvx5kYf/yu2zkgrKLR0AuAzCmNksQbgocer5PZ
9SASr2ErBseAwpcOJoDpjLcnpR9E+a8rScQDcB12s6XqecdklVL6uW2w+Twwi5Ed
0zDJ/41GCN6veCyNgvszVKKvfelylIFzTEma8Hq7YhFDz35gHXsK9XZPNcnLKHai
5t2YyK/UwOsKPqjA5VzVNIxdYWjaAvyiWM9Yr5pizXYmoi696DrlCw2jHmhqrGuE
0Bqr6VX9h0B6Jslo0eTh662KGkW8N6vmmdhowNjNDKCz0wr0m4Vck+6HJz+tES8t
BTQ2hKKEfU8cbpTEV8JG9XyxItuDVzxpFhTawlOEAfr9kVAPh6EgkDIvx59IFhXq
SVPtxsJeRi0SRg3IQq2ArkjhuYJtZhf9IhcmqrJGwTd1+/fWWHSFhpDdATRfni1y
NnJHUvFS/gVk5kOATYL4
=kok7
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
