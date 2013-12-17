From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 17 Dec 2013 22:13:09 +0000
Subject: Re: [PATCH 3/5] arm: shmobile: r7s72100: add nodes for i2c controllers to dtsi
Message-Id: <20131217221309.GD1196@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DrWhICOqskFTAXiy"
List-Id: <linux-sh.vger.kernel.org>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-4-git-send-email-wsa@the-dreams.de>
 <1632121.4oJZuIln5n@avalon>
In-Reply-To: <1632121.4oJZuIln5n@avalon>
To: linux-arm-kernel@lists.infradead.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 17, 2013 at 10:55:31PM +0100, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> Thank you for the patch.
>=20
> On Tuesday 17 December 2013 22:44:36 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> >=20
> > I decided to put the pinmuxing into the dtsi file since there is only
> > one pinmux posiibility which one probably wants to have when using the
> > bus.

I tried to explain here why the pin-groups are in the dtsi.

> > +		riic0_pins: i2c0 {
> > +			renesas,groups =3D "riic0_scl_p1_0", "riic0_sda_p1_1";
> > +			renesas,function =3D "riic0";
> > +		};
> > +
> > +		riic1_pins: i2c1 {
> > +			renesas,groups =3D "riic1_scl_p1_2", "riic1_sda_p1_3";
> > +			renesas,function =3D "riic1";
> > +		};
> > +
> > +		riic2_pins: i2c2 {
> > +			renesas,groups =3D "riic2_scl_p1_4", "riic2_sda_p1_5";
> > +			renesas,function =3D "riic2";
> > +		};
> > +
> > +		riic3_pins: i2c3 {
> > +			renesas,groups =3D "riic3_scl_p1_6", "riic3_sda_p1_7";
> > +			renesas,function =3D "riic3";
> > +		};
>=20
> The SoC allows other options for the I2C pin groups. Instead of declaring=
 all=20
> possible groups here, I think we should thus only add the groups that are=
=20
> really used to the board .dts files.

Really? Couldn't find any. This is why I included it here: since it is
the only option, people probably want to use it when they activate the
bus.

> > +		clock-frequency =3D <100000>;
>=20
> Isn't that a board-specific property ?

It is meant as a sane default. Can be overridden.


--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSsMx1AAoJEBQN5MwUoCm2wf4QAIjsJ3rxS0Hkc2GzxlNaDipt
PVTmbGHHoR4vewJVSzlJj85kfFrQA4jjq8j5xv9r0PksfmEIONgSXW9HE62iB/S9
+wHqvxsreTq2YTuFJfP01P0ILsAVdWfAeaBiCQqTZ6JgpK/a2FDbFEcTob0W3JQH
k2dRL7nuG+23er/q4qM9rVt3U8sfohw0gfEKXkwKaBzzAFmXoNKfgejJi6EGBhGe
mg6MZYRGyCQRCzOLw+xUyAJfFQBACepq72+Vx+8Rg6XLPmGyAYBBu6VNCJd2o7ef
xYDpvojmM303CbavMKjKDriAzUvdzq6zVdDheCZL9vVJYD8MiHVww2mpY4O8Mim+
UA6K5Et5Rzf09mE1wHbgFlxTSmsrIlmJtCff9UeFTy6Z7OKpH7ePY8EfQUHRteHU
WfX7+dZ2eEFxGm48QFbaYApU42pjvLUGljqMzIbISPpIcDQNUY7NLEl8M63QQcdZ
zzqoRFjrStJSBXlpzVLN2YrEzOkNTkpyr1e/BPIzv/SQd1nB6PC/kSGKIlkqrqnB
TKdNUrwpWQ6TckU5h/MPGOo+Or72QYHi8YPGkPssSOKH8xbhyvd9k4jVlCwEIK07
h6gR9sWOIaNtBxh3QR1QTMvw29b5vzGjsv9yAAXf1fcCTnzK25fw52bAHDITlDir
61yeP2lGMoDa7EpkXOSR
=P3S0
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
