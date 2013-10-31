From: Mark Brown <broonie@kernel.org>
Date: Thu, 31 Oct 2013 17:49:45 +0000
Subject: Re: [PATCH v3] iommu: shmobile: Enable the driver on all ARM platforms
Message-Id: <20131031174945.GI2493@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mu9njEoJVcULXJK5"
List-Id: <linux-sh.vger.kernel.org>
References: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131030112625.GZ16735@n2100.arm.linux.org.uk>
 <1652955.Gs3XDiEUHO@avalon> <20131030162854.GB2493@sirena.org.uk>
 <20131031060305.GU1603@verge.net.au>
In-Reply-To: <20131031060305.GU1603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--mu9njEoJVcULXJK5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2013 at 03:03:05PM +0900, Simon Horman wrote:
> On Wed, Oct 30, 2013 at 09:28:54AM -0700, Mark Brown wrote:
> > On Wed, Oct 30, 2013 at 12:40:12PM +0100, Laurent Pinchart wrote:

> > > > For similar reasons as x86, can we please think about using:
> >=20
> > > > 	depends on ARM
> > > > 	depends on ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI || COMPILE_TEST

> > I'd read the above as saying the code needs ARM to build at all and that
> > the hardware will only ever appear on SHMOBILE.

> I am curious to know the value of "depends ARM".
> Is it to aid the reading that you spelt out?

That's a function of the compile time dependencies, if ARM is required
to build then it needs to be an unconditional dependency.

--mu9njEoJVcULXJK5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScpg1AAoJELSic+t+oim9G+sP/Rmpi2B9OiuHSNWqL/4ODXYG
EbjlQZy4om0HpdthkkDPOut71c7gR4sqtn9wtex+leCU/VXA4PnhpThyrLnpkWpU
V/S6p3k+hXRJI2jV/R11cr9+buMlJbPNq2RV46exwLGP31zcVrlrim3FKnDUT5bO
uW5cuExUhlncFMmK/BnAN6SaUudAcilJ2FyC2QaIC8w+HzH/yb1FuBIMrVz+HRPt
UORjJXWfNj52i210qGPnSayM0rG/SXsubVq0C/ufOMQ2HAB6lgjs+JFjoONWFJE9
JNXwib3FtTTllkyW/GUKgAUg35RZL4BZoAqg/kF91ABG76GVviX7CPLMSADnvum+
fvhfac95SWhhymAPq2N9AnuUtxGgPMhUxVFKiXtLuTS3ws72u8skOe7rVI/AOLQ4
xI2mmD5Hyu+1EAZR18Z1ecLl/tVrE5pNdJnnMM0jZ/s5gxd1mh1djDXFKXD/+0ka
ra6s6mT1fKXN1WCcT069o5UtNsR1RZxE6n76kvMs26K1XReK5DIXMENfNDVQ6qoI
NCMGUBrJX50viCpFMrW6305qkKQlc8nf/WnGjHJygVXnQLARtpf+tMmj8nOt+cYI
VsRqb/XcaH+hHiPOox12UUEmdIihDM/U8eit/4e9vTyYJZCeuyWWaPkp4o9rBQnT
/ewx8aq1WETESmPxLRx8
=xjJx
-----END PGP SIGNATURE-----

--mu9njEoJVcULXJK5--
