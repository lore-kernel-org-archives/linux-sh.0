From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 17 Mar 2015 10:45:13 +0000
Subject: Re: [RFC V2 3/4] ARM: shmobile: r8a7790: lager: add i2c-demuxer to dts
Message-Id: <20150317104512.GA907@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
List-Id: <linux-sh.vger.kernel.org>
References: <1426576524-22315-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426576524-22315-4-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2015 at 11:13:02AM +0200, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> Thank you for the patch.
>=20
> On Tuesday 17 March 2015 08:15:23 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >=20
> > Changes since RFC V1: rebased, added the sound-codec entry, fixed a typo
> >=20
> >  arch/arm/boot/dts/r8a7790-lager.dts | 66 ++++++++++++++++++++++++-----=
-----
> >  1 file changed, 46 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
> > b/arch/arm/boot/dts/r8a7790-lager.dts index 0c3b6783b72add..bf0065d6764=
28d
> > 100644
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -222,6 +222,40 @@
> >  			};
> >  		};
> >  	};
> > +
> > +	i2c-demux {
> > +
> > +		compatible =3D "i2c-demux-pinctrl";
> > +		i2c-parent =3D <&iic2>, <&i2c2>;
>=20
> Purely from a DT point of view, wouldn't it make sense to call the node i=
2c-
> bus and rename the i2c-parent property to i2c-masters ?

I'd think so. I chose "i2c-parent" to be consistent with the existing
i2c-pinctrl-mux driver. But I don't think we need to uphold this.


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCAW4AAoJEBQN5MwUoCm2lgQP+QHd7N77JwVpPXwP8RT5jnoo
qRdkddQJeegaFhP+AgnAKpVIRJDZZn7DGVUFuSchFolGJEAgCpVsnNaMSysS/X4D
7L4cRaXzgs3FliLsQYqjhijytp1R6jZ0CQHt+Xaqouu6Gobf6+fycQnpkASKLovJ
I1XkG9L0wAZz/Hr8K5DvPlByvEH3MJHjYYl76IxdH05M3nObRGQAw5loV6i87+ia
Q51maPT4ij98cMBKf5oCc6jsu9v9/LBxJFMxJ87hUXZxv6URbYjJNDG8JDrmmfhk
akOYF4rH3z8C9rsA/sSbmfT2BuJn3UuFf9RDmn8p37Gsr3ssY20bAatNnMKBE89+
Mf/djtbJz90/286GkPg4bg73qu/1Ha3L+85dcLQN4IH5DriTSOeInP81snbCah66
awcVvuJRGCzgCpwBdY8EmLGQXFZbVSTr+TBuxfV2zTsI/nW5fstXheskFC/yhX3l
FKKSjWEczjjkuRJmfQw8VbTkETqIiqoHs8SSQ2Uto0xjla2E7Q0ofzQcyDqVx4Fv
/Rixitj+duY8e22IxbmmWTH9sJ/Z16hp8XcV35IJVcctGPJqVNND4t6XGYq7gv84
t16QkCT0pp2LzPyUFYsGgbH7CcpvsEgTRDWHlOkyJYb8j6EetP+tRJjAu2Fw+/aH
vxUgNjrHTGhXgjOs9J1U
=uT0z
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
