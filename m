From: Mark Brown <broonie@kernel.org>
Date: Wed, 11 Jun 2014 17:02:33 +0000
Subject: Re: [alsa-devel] "ak" vs "asahi-kasei" (was: Re: [PATCH 3/3 v3] ARM: shmobile: lager: add sound supp
Message-Id: <20140611170233.GL5099@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="S8hWgp6Wl+RBuNna"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>
 <87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
 <539815E6.2050304@codethink.co.uk>
 <20140611165410.GK5099@sirena.org.uk>
 <CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>
In-Reply-To: <CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>


--S8hWgp6Wl+RBuNna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2014 at 06:57:44PM +0200, Geert Uytterhoeven wrote:
> On Wed, Jun 11, 2014 at 6:54 PM, Mark Brown <broonie@kernel.org> wrote:

> > They're usually referred to as AKM when abbreviated and their web site
> > is http://www.akm.com/ - don't know what the stock ticker symbol is.  In
> > any case there's no real cost to adding both abbreviated and
> > non-abbreviated forms if we want to transition.

>     of: Add vendor prefix for Asahi Kasei Corp.

>     Their stock ticker is 3407.T which wouldn't make a good DT vendor
>     prefix. Use the company name initials instead.

Sounds like akm, is a better bet then, especially as ak, has no real
adoption. =20

I think the bikeshed would be much better painted pink with yellow spots :)

--S8hWgp6Wl+RBuNna
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTmIumAAoJELSic+t+oim9il0P/AsBwqZVFudkdRfYRyhAOmX+
uZ7zCFGGyIO3C/o4J+pomcBf0eogohmiW+IHGv2dPGWGRRgXXduaml8UyExlK26Q
FP+CJMrMFdkAyInrdN040rVCIdPQ8XLoBaDgc1Smp+MjlLHY9EZUJJ39mmElrEWx
h0a62ajVxS2fYdFi+H/OBIpPd43yNkR2+dYSiICNDCmbJUXQQshi2xQ02Kk3Biw+
8MbPb1ClyDon3YwkfnM/9uts7PLtSGknmVaemKeSX6fK4V/iCzBMX4Z0KXbuRu/k
nw1goxYVHbQqjVjfHP3q762tPVmJXdNpJzz1UQb32FIQ0lCUHwCYzFixEIr9tpve
Cc5JcqbhvUcUD0j4hEkXQGXOR8bjLTMoyfbxVHG0YtOi9IuXid/NOgmD2/seIsjF
c4AHA++1ftV9C8XIKn0Wku1/xzHZi725bhimm41K5KGPfzHUR8sO7hw3/i9ulwZr
GjUtyag4oUlZ/qYFvmjy34aH6ZPXE13noYppeam9bUdL4nrHr5mG6Wwxb+I1p7NU
8FkZL+gOssaYfBinsw7Jw9UxWeTmRcTuTKLqWEeoS2BQNspJtwZCa9tHqrFdnsHh
Qbufqx2uF93sU705XPk/4wyUN8rOmshzpOuGW31Ct6wUeRFMzWsZefKnsT+7wGJm
A8bLbCeEM1hD+IqTg1X0
=KENT
-----END PGP SIGNATURE-----

--S8hWgp6Wl+RBuNna--
