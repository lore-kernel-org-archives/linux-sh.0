From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 14 Dec 2015 07:11:03 +0000
Subject: Re: [PATCH/RFC 03/19] ARM: shmobile: gose: add i2c2 bus to device tree
Message-Id: <20151214071103.GC1516@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="c3bfwLpm8qysLVxt"
List-Id: <linux-sh.vger.kernel.org>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-4-git-send-email-horms+renesas@verge.net.au>
 <566AB2A5.4090105@cogentembedded.com>
 <20151214021110.GD13945@verge.net.au>
In-Reply-To: <20151214021110.GD13945@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >+	eeprom@50 {
> > >+		compatible =3D "renesas,24c02";
> >=20
> >    This is not a valid value -- the Renesas chip model is different fro=
m 24c02.
>=20
> I copied this value from r8a7791.dtsi.
>=20
> Looking at the schematic for gose (v100), koelsch (rev024) and porter (v3=
00)
> I see the following "R1EX24002ATAS0G#U0". Shall we update r8a7791 and
> this patch to "renesas,24002" or leave things as is?

I wouldn't like to update the at24 driver with all namings from all
vendors for chips which in large cases are simple 24c02 devices.

So, if Sergei insists on the change, I'd propose

	compatible =3D "renesas,24002", "24c02";

to keep things sane.


--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbmuGAAoJEBQN5MwUoCm2RdcP/0EVN2SatKE+Kd/0/t3zYNip
RVT3wpkzXkZar+tEazXjhDFIHT+SzcC+2/i0IlxRVO9nGhAHT+SixdX2Z+GEKfp/
aw40VARTBbhcHlsT4oocKfI8L6gkccZ3KP2Mnr4EhvEoFkwRvdJbNGCqDTJD1R+0
rLekhY0T6Zv0jZAsWk0KLnKmLZ9b1MFIoFXZIYH/+1E9ivihFj9PwwSS6fLSO5X/
6+jJ12m/4GJ7MC9o+d09FD/8e9Ircb4gbCLt06xP9zn+ZXfpMslXy4enjvu/rtWk
iBcUKyGi80gUX0RNOQenfnUIu6X1UhRqALNJNtcNtlKDQYHS6jQ0yARj6g/5m+65
pwfP/W29zY84FfY0SIRntexZQDvYYcBClG2Gs7muVh5EuGFMp7nspm6xuI+drmUQ
gKJ10cGb4nhhpP9GZbxRGXG81vaabXT6gFJ4J1c0KaAcqdBP4oF474mqmUexNj7R
oUuYEHaRLk7BEG8kyq1C/eL2brQW9L32AahMYk3uGpFwLohj11h6ix2ldk8MS8iJ
zASmEgVKD25MviZo6h368PcAjsWd7z8b+6MzfGKw8wuxj9k1aKgHDpg1RbbgRjPG
JOzXQLH5+HTa6ZGF9ZJ1cqWqUw9WYbYPw+VsioyH5sSubeKpQE1OxSHL7qrCwhx8
daUixuOyRJqd6FKDZvkh
=A0Hn
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
