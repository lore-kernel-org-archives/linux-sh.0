From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 10 Mar 2014 12:38:37 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <20140310123837.GB7227@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GID0FwUMdk1T2AWN"
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon>
In-Reply-To: <5448979.WQPtOb56tW@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I've recently reviewed a patch adding serial port aliases to the device t=
ree=20
> and would like to pick your brains about a disagreement I had with the=20
> developer.

And here is the developer :)

>=20
> The SoC includes 8 serial ports. They are all disabled in the SoC .dtsi, =
and=20
> enabled selectively by board DT files. As not all serial ports are availa=
ble=20
> on all boards, the question was whether to add aliases for all ports (in =
the=20
> .dtsi in this case) like
>=20
>          serial0 =3D &scif0;
>          serial1 =3D &scif1;
>          serial2 =3D &scif2;
>          serial3 =3D &scif3;
>          serial4 =3D &scif4;
>          serial5 =3D &scif5;
>          serial6 =3D &scif6;
>          serial7 =3D &scif7;
>=20
> or to just add aliases for the enabled ports (in the board DT file) like
>=20
>          serial0 =3D &scif2;
>          serial1 =3D &scif3;
>=20
> Note the numbering in the latter case: as the board doesn't use serial po=
rts 0=20
> and 1, hardware ports 2 and 3 become logical ports 0 and 1.
>=20
> I considered that having Linux create ttySC0 and ttySC1 devices for the f=
irst=20
> two ports of the board, regardless of which hardware ports are used, is=
=20
> simpler from a user point of view (it allows sharing the same inittab set=
tings=20
> for the console serial port across several boards for instance). I'd=20
> appreciate feedback on that.

First, I don't think this is restricted to serial ports but how to use
aliases in general. We may decide this or that way, yet we should do it
consistently. Using aliases this way for serial ports and that way for
I2C busses will create a mess.
And currently, I only know of 1:1 mappings for I2C/SPI. So, on the same
board, you'll need to open /dev/i2c-2, not /dev/i2c-0.

=46rom my experience, things get complicated when stuff gets added and the
numbers go wild:

          serial0 =3D &scif2;
          serial1 =3D &scif3;
          serial2 =3D &scif6;
          serial3 =3D &scif0;
          serial4 =3D &scif7;

When debugging here, trying to remember which port to open for the
terminal, and which number to scan for in the schematics is error-prone
and a PITA.

Yeah, the drawback is that the console might be at different places
across boards. I suggest to update inittab at runtime anyhow, since not
only the number but also the naming often changes (ttyXYZ to ttyABC).

Regards,

   Wolfram


--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHbJNAAoJEBQN5MwUoCm2nN4QAIJkDShWNBw5af+/8C1o/yb3
yQya2N3n7wUV1ZJlQKoysYkbPFHJLspSWVvSzD1j02oX8R51z83TzkOtTmmPrz9M
4VX6vZ4TI0FMHon6k6LBR5Aq5004EJu/KF+iqBSRergjvsESHyMBa3dklFP3lPfl
VkU6dDOP6EJnNmzKRCHPEus1exb9DO69KBRhi3IdOyeOpK4wi1oXSmeYwfb4c2TO
25d03StWOVYSheM9j65i7tjTBdAB8kGgeybrRttmVLwTMJKx0cQXb2Hv927Vyswo
YggU0eBBs63vjgWmecpsCmQZylgOoTZ5dISg3t/K1brGCwhPjPNSDCrcd3Skg5/6
Rcow+o3E89g+ZSquViatCmysNk3MAB+ZBzcjeLsLVXzK4CX7zer6fv908EDepCG/
kC5PMntanutLsdhICdMMTsk7fZDBwO1RGyDlQXBTRVpLSRFOlwyqsAm0bZZUftm3
svGcYpM3HbNxpK4VRy4jtQ35jXmPElDx0CvAwBsMjJJDOTiQDC+jVrVEZvXgYiXb
ZXIyTBGVOw71iQLiSPXngS92iaF/sM9h9cXRRtYq/qqzcQD0TiMoDQcSLCfrC7X4
6nlWWph6+LEp9P+/BH8yhLx/UClZirMhZVtBISk3/R0JNkn+PF8tjb600bNSecUN
8qhnunr3agq5CnoekyOK
=edcx
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
