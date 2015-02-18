From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 18 Feb 2015 07:22:56 +0000
Subject: Re: [PATCH v3 07/15] ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
Message-Id: <20150218072256.GA2781@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
List-Id: <linux-sh.vger.kernel.org>
References: <1424105939-4910-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424105939-4910-8-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-sh@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2015 at 04:42:08PM -0500, Simon Horman wrote:
> Hi Wolfram,
>=20
> I am thinking that the binding portion of this patch could be re-posted as
> a separate patch for you to handle? What are your thoughts?

You can have it :)

Acked-by: Wolfram Sang <wsa@the-dreams.de>

>=20
> On Mon, Feb 16, 2015 at 05:58:51PM +0100, Ulrich Hecht wrote:
> > Cameras, RTC, and ak4643 sound codec.
> >=20
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  .../devicetree/bindings/i2c/trivial-devices.txt    |  1 +
> >  arch/arm/boot/dts/r8a7778-bockw.dts                | 25 ++++++++++++++=
++++++++
> >  2 files changed, 26 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt =
b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > index 9f4e382..b6fe29e 100644
> > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > @@ -75,6 +75,7 @@ nxp,pca9556		Octal SMBus and I2C registered interface
> >  nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
> >  nxp,pcf8563		Real-time clock/calendar
> >  nxp,pcf85063		Tiny Real-Time Clock
> > +oki,ml86v7667		OKI ML86V7667 video decoder
> >  ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with =
OmniBSI and Embedded TrueFocus
> >  pericom,pt7c4338	Real-time Clock Module
> >  plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
> > diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8=
a7778-bockw.dts
> > index 7347223..280a922 100644
> > --- a/arch/arm/boot/dts/r8a7778-bockw.dts
> > +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> > @@ -59,6 +59,31 @@
> >  	};
> >  };
> > =20
> > +&i2c0 {
> > +	status =3D "okay";
> > +
> > +	ak4643: sound-codec@12 {
> > +		compatible =3D "asahi-kasei,ak4643";
> > +		#sound-dai-cells =3D <0>;
> > +		reg =3D <0x12>;
> > +	};
> > +
> > +	camera@41 {
> > +		compatible =3D "oki,ml86v7667";
> > +		reg =3D <0x41>;
> > +	};
> > +
> > +	camera@43 {
> > +		compatible =3D "oki,ml86v7667";
> > +		reg =3D <0x43>;
> > +	};
> > +
> > +	rx8581: rtc@51 {
> > +		compatible =3D "epson,rx8581";
> > +		reg =3D <0x51>;
> > +	};
> > +};
> > +
> >  &mmcif {
> >  	pinctrl-0 =3D <&mmc_pins>;
> >  	pinctrl-names =3D "default";
> > --=20
> > 2.2.2
> >=20

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5D3QAAoJEBQN5MwUoCm2/mQQALYnfaLsNiAs72qICWLbn6t9
xnhBc1AYEPDotiCxlZemaxItWz1Y4oJJpl6Jd28/bnPoMHlZOBdBXINY27RMel35
qm+i9aNr+HLhS0J+XICU6ecqk+rRs2tCCvk9/PHRANauNOHwyZW8flH7xSm+4YnO
eNhPgKOofEQmXFg2TkP7hfmsmbF8xekn4NAL64mDorCgOBACXNrk8Ub/wa1zoRCs
V0gM72H28DpFU+WfXa8nltbJELmvA0KzColrw/JEbncaEOQnMehNb3jzdhh5TS5W
C6lXeCF02okXFoX+mqVFRwEyQTf3Tv3UPWxVNl+SQ4J6PdPT9vOkXCgdP9CHBCPq
pikgaE5sTGTgow1vIdxG2GoObUjb0hM0YqLMHLDhuzpap+R3wAGMgNSGscYb1c6L
EvI0N+s+UFvEKTWI7moabKdlcxzgKxRAuThXp/mzLpFipE2iBTKfsd30letqSWUf
UQa2uOKVDCXD84ez+xoHrKzVE1TC3h+ohhyCmxT29zWz6PjWONU1HQtZRwMc1huY
9b4EhUxyBnYCZqPRxEQNQeeP+N5F9veJMJ7fmWJT9/WWdKvUo7KsPB/HL8ULJ1U+
3KNdbMew9T4XyXsuvWtkeYcOZ2VPwzetHbT9U4LMgTX0gfG+tn1zICRC+aU4Kbpm
+1N3SQG/SAk2sa1YRieW
=gz1H
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
