From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 18 Dec 2015 10:32:15 +0000
Subject: Re: I2C eeprom compatibles? (was Re: [PATCH/RFC 03/19] ARM: shmobile: gose: add i2c2 bus to device t
Message-Id: <20151218103214.GA1532@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
List-Id: <linux-sh.vger.kernel.org>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <20151218030239.GB10973@verge.net.au>
 <20151218073531.GA1517@katana> <1839177.77Qt0RnI3v@wuerfel>
In-Reply-To: <1839177.77Qt0RnI3v@wuerfel>
To: linux-arm-kernel@lists.infradead.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 18, 2015 at 10:06:48AM +0100, Arnd Bergmann wrote:
> On Friday 18 December 2015 08:35:32 Wolfram Sang wrote:
> > >=20
> > > It seems to me that we have some consensus around:
> > >=20
> > >       compatible =3D "renesas,r1ex24002", "24c02";
> >=20
> > Thinking again, "generic,24c02" or "generic-24c02" could also be an
> > option.
> >=20
> > > Should this be added to Documentation/devicetree/bindings/eeprom/eepr=
om.txt ?
> > > Or documented elsewhere?
> >=20
> > Probably we need a DT maintainers advice here? I don't mind vendor
> > specific compatibles being documented, but I'm reluctant to add all
> > these compatibles for the myriads of I2C eeproms to the at24 driver. 99%
> > are covered by the generic case.
> >=20
> > Adding DT to CC.
>=20
> I'd rather use some vendor string in addition to 24c02. Isn't this origin=
ally
> an Atmel part? In that case, using "atmel,24c02" as the most generic stri=
ng
> would be appropriate,

Yeah, the at24 driver is named after Atmel chips AFAIR. Having "atmel,*"
as the generic fallback sounds like a good solution to me, too.

> and IIRC the i2c framework will just match that with
> the "24c02" entry in the i2c_device_id list.

True, although this behaviour is often complained about. There have been
attempts to make i2c/spi behave like the rest of the DT world and to
deprecate the current way. It didn't happen because of lots gory details,
however :/


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWc+CuAAoJEBQN5MwUoCm2IVEP/A6WBkDVerA3v8dvbXFGdlkP
caFknBFInEvJsXHQK/tILCyPpkTJCTEoMf8eXmDqXG8lt3tZU9qR7w+9nvzT9oXR
kvER+hd8//lFksL0NTOKp9E87jIzt2AdIWf2l39U/etmw5RZ9YW+sWH+AbdKG/Gc
DHTQQR3079KbZl+m2179FzquVTvoA2M7L+5TrM7e+Odu4w29/FwvMJBGIZQvN43g
HUjTszIvzp3aa2hLVWqxBzugRNw+OL6w5eXno55n6mNdfUMXvoItImW6u6jAmBsn
uTCrXcH3hSLPZ/idLGdON1URaNOcfyucqOmUsX3AXRyeJSfe9nqPbU5aNlmrGhxY
62+mT4igsi4+JKOrah58GUnpcOkCXRi56woA+INQRGgeFqD4gCYyrzt/PjHbtkcc
JX5jN5W5qMzh5gTgoEyEZHjMQFCv8pTSwJiB4ANsMGAdiaNVFpba+QU6AVJ0Bcrj
Rf/IT+IwYZZU3glKwJKHAQ/mFiGtoWFVVAg0/gXUfsfQmHI6DBhZLS1bZ/1bGokL
P2iyHY9FStBKGo0WS8p03eyjfknlQCaldAl/JfmXq/m6mNYDYZkzK4GPOXCU93RV
msg1tf9PNnipW/TYELG29v4RYQwMVfRDMxWeuQckOrAmsaixNj9KibHQM/lziM8N
16/dG1+A10xn5N1PpkGl
=bjZC
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
