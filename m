From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 11 Mar 2014 12:46:22 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <20140311124622.GA30394@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon>
 <20140310123837.GB7227@katana>
 <1551855.ylN84WQiIN@avalon>
In-Reply-To: <1551855.ylN84WQiIN@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 12:56:50PM +0100, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> On Monday 10 March 2014 13:38:37 Wolfram Sang wrote:
> > > I've recently reviewed a patch adding serial port aliases to the devi=
ce
> > > tree and would like to pick your brains about a disagreement I had wi=
th
> > > the developer.
> >=20
> > And here is the developer :)
> >=20
> > > The SoC includes 8 serial ports. They are all disabled in the SoC .dt=
si,
> > > and enabled selectively by board DT files. As not all serial ports are
> > > available on all boards, the question was whether to add aliases for =
all
> > > ports (in the .dtsi in this case) like
> > >=20
> > >          serial0 =3D &scif0;
> > >          serial1 =3D &scif1;
> > >          serial2 =3D &scif2;
> > >          serial3 =3D &scif3;
> > >          serial4 =3D &scif4;
> > >          serial5 =3D &scif5;
> > >          serial6 =3D &scif6;
> > >          serial7 =3D &scif7;
> > >=20
> > > or to just add aliases for the enabled ports (in the board DT file) l=
ike
> > >=20
> > >          serial0 =3D &scif2;
> > >          serial1 =3D &scif3;
> > >=20
> > > Note the numbering in the latter case: as the board doesn't use serial
> > > ports 0 and 1, hardware ports 2 and 3 become logical ports 0 and 1.
> > >=20
> > > I considered that having Linux create ttySC0 and ttySC1 devices for t=
he
> > > first two ports of the board, regardless of which hardware ports are
> > > used, is simpler from a user point of view (it allows sharing the same
> > > inittab settings for the console serial port across several boards for
> > > instance). I'd appreciate feedback on that.
> >=20
> > First, I don't think this is restricted to serial ports but how to use
> > aliases in general. We may decide this or that way, yet we should do it
> > consistently. Using aliases this way for serial ports and that way for
> > I2C busses will create a mess.
> > And currently, I only know of 1:1 mappings for I2C/SPI. So, on the same
> > board, you'll need to open /dev/i2c-2, not /dev/i2c-0.
> >=20
> > From my experience, things get complicated when stuff gets added and the
> > numbers go wild:
> >=20
> >           serial0 =3D &scif2;
> >           serial1 =3D &scif3;
> >           serial2 =3D &scif6;
> >           serial3 =3D &scif0;
> >           serial4 =3D &scif7;
> >=20
> > When debugging here, trying to remember which port to open for the
> > terminal, and which number to scan for in the schematics is error-prone
> > and a PITA.

No comments on those? Are the experiences from the stable ethernet
naming which would speak for/against those arguments?

> > Yeah, the drawback is that the console might be at different places
> > across boards. I suggest to update inittab at runtime anyhow, since not
> > only the number but also the naming often changes (ttyXYZ to ttyABC).
>=20
> Just out of curiosity (as I could use it), do you have a sample implement=
ation=20
> of dynamic inittab updates ?

Sure. Can be optimized and improved, but does its job (for an initramfs
at least, where the default 'ttyS0' keeps constant):

=3D=3D=3D S02inittab

#!/bin/sh
#
# Update inittab at runtime - by Wolfram Sang, WTFPLv2

case "$1" in
  start)
	echo "Adapting inittab to kernel console"
	l=3D$(cat /proc/cmdline)
	l=3D${l##*console=3D}
	l=3D${l%%,*}
	sed -i s/ttyS0/$l/g /etc/inittab
	kill -s SIGHUP 1
	;;
  *)
	echo "Usage: $0 {start}"
	exit 1
esac

exit $?

=3D=3D=3D

Regards,

   Wolfram


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHwWeAAoJEBQN5MwUoCm2P7wQAIHsKadbAIEBionSGPqiL2OF
gvTXbOtgfMEKUjoCBrq8gfTsGVA9B9VAxF5uRlStSqRhX21V3xcPM/hQAwWohJ3A
l9McBcHI+/syocQg860Y3VhgSaNChMw4A5lEMe+kQXOTI5yXVHUre1ZVtLVJqeqf
WTSljmg6iXgeC1/pivKN04Fx3DyCAcJNVU2MK0NwvhWg39DsUgHfg0oyjIHmqFTv
TkTNPAVjjgE9OduYJQtvqJ2MHG8OTBoUxd4XMswUzWjtv1eb2FTteF6yPyO7usMQ
qszoDH8GQwLDxfUZgotorsQMlkhBGG9CsgQw2TCAMyhwfCTDpufMDZa0XmFBtm5a
nSFpQhE4gb9w+CDlfCo5fL/aBtxN6WkOx/npY6HDigV1FqFnAckQlHN8vZKjNUA2
reTxb20a6s2BSh+svcB4Yj/d6bCDzUZpCh0L0rmx7+UEXItUWUxCDT+tFqj3aIKo
7JESj9npmBAAhkvRTkl3WnsE7/EdplnNEPf/+k8DAA+dXDh7EMVX7E9Il3T9LUTY
WL/lBPXHmgrWdAZehyUXyRZBEq4b/GAhPhgwuaPyL8OdK74dhOCacZT6xXcCy8gT
m9gFhGVVS8FXr44XbnsE7UNxZi8OKIVm3ShZ3kChFp7qLQ3cDWgy0MMGbo871uBw
4Ss9+JdqDz6xLVJw33fu
=V1L1
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
