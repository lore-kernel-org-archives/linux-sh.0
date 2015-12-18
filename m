From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 18 Dec 2015 07:35:32 +0000
Subject: I2C eeprom compatibles? (was Re: [PATCH/RFC 03/19] ARM: shmobile: gose: add i2c2 bus to device tree)
Message-Id: <20151218073531.GA1517@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
List-Id: <linux-sh.vger.kernel.org>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-4-git-send-email-horms+renesas@verge.net.au>
 <566AB2A5.4090105@cogentembedded.com>
 <20151214021110.GD13945@verge.net.au>
 <20151214071103.GC1516@katana>
 <CAMuHMdXWcyEmoVRZuCTM4yqfxXYjgZF1yP8uqCEU8Bj=pmkNYw@mail.gmail.com>
 <20151218030239.GB10973@verge.net.au>
In-Reply-To: <20151218030239.GB10973@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 18, 2015 at 12:02:39PM +0900, Simon Horman wrote:
> On Mon, Dec 14, 2015 at 10:39:47AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Dec 14, 2015 at 8:11 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > >> > >+  eeprom@50 {
> > >> > >+          compatible =3D "renesas,24c02";
> > >> >
> > >> >    This is not a valid value -- the Renesas chip model is differen=
t from 24c02.
> > >>
> > >> I copied this value from r8a7791.dtsi.
> > >>
> > >> Looking at the schematic for gose (v100), koelsch (rev024) and porte=
r (v300)
> > >> I see the following "R1EX24002ATAS0G#U0". Shall we update r8a7791 and
> > >> this patch to "renesas,24002" or leave things as is?
> > >
> > > I wouldn't like to update the at24 driver with all namings from all
> > > vendors for chips which in large cases are simple 24c02 devices.
> > >
> > > So, if Sergei insists on the change, I'd propose
> > >
> > >         compatible =3D "renesas,24002", "24c02";
> >=20
> > "renesas,r1ex24002"?
> >=20
> > I don't think the "A" is relevant (<=3D 64 is A, >=3D 128 is B).
> >=20
> > http://www.renesas.com/products/memory/eeprom/product_selector.jsp
>=20
> Thanks.
>=20
> It seems to me that we have some consensus around:
>=20
> 	compatible =3D "renesas,r1ex24002", "24c02";

Thinking again, "generic,24c02" or "generic-24c02" could also be an
option.

> Should this be added to Documentation/devicetree/bindings/eeprom/eeprom.t=
xt ?
> Or documented elsewhere?

Probably we need a DT maintainers advice here? I don't mind vendor
specific compatibles being documented, but I'm reluctant to add all
these compatibles for the myriads of I2C eeproms to the at24 driver. 99%
are covered by the generic case.

Adding DT to CC.

Thanks,

   Wolfram


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWc7dDAAoJEBQN5MwUoCm2Av8QAKhX6PL38w64rPZrEEn/1s2f
HxOD/TgoKj32Qw9LPL8PmLX92xLAcd20edsVovHiqXCHQI6UEoLFXrbhnP1TAdik
p37vgfSMRwP/SbtD2IlmVzmAXzQHocobU0gZJRyxbsGLHT5Ifnbaw/qVAqQFNJop
k9OD/0wYYcXZ5TJ6LNS6lOnMokvZ7b3ANl21e0zlKNluhJaD2EvrYQqhyl6ktVQX
2tkGG047xAFlo3YVSoBUzLSr0ps1h0sk55TXFUfJ6YrX5Z7LhSwpBrG0Og/hGMjV
CLY+pwmzSvv8RFN+uiBPtQImI06gPICMAp/QaxcbHpM64APHfqThRYalduYIw+6Y
+EaXrD8k36Rx9S86MKnc+GtC8baAsuRbvP4W9ZLesXy6N+qIyhAT5Vpi8ktiopuP
1PZ9OPdqEut9awBJaNl6zUbV9mmwaLuyCmuXlSsUrXTPJzhZRepHRQTIWwHp8RIH
Ztj+tjP67/iFOyEfY0UpOzWMhpfTSAA4i7sCrLn/xfo1Ayc2vcPLvb9gmqsNonSl
alVwNI8i1Va63KJbv9n5WdbuGw+ZBcvszT0RdZ2Eis7m2a2bCIsniSQzs6DOXGdA
0XyZ6WEIKDqaNxlOULw/2X2KlfDXwgbWDT4dwBVshAe53xrN8SuqmJanpo/EJRnN
Sxk76RkM7Igoz3sfqrWl
=uf5c
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
