From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 04 Jan 2016 16:11:57 +0000
Subject: Re: [PATCH RESEND 1/3] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <20160104161157.GB1599@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="R3G7APHDIzY6R/pk"
List-Id: <linux-sh.vger.kernel.org>
References: <1451874827-2531-1-git-send-email-wsa@the-dreams.de>
 <1537546.GLmkeJiXH5@avalon>
In-Reply-To: <1537546.GLmkeJiXH5@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2016 at 04:37:44PM +0200, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> Thank you for the patch.
>=20
> On Monday 04 January 2016 03:33:45 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > The interrupts for EDID_READY or DDC_ERROR were never enabled in this
> > driver, so reading EDID always timed out when chip was powered down and
> > interrupts were used. Fix this and remove clearing the interrupt flags,
> > they are cleared in POWER_DOWN mode anyhow (according to docs and my
> > tests).
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/gpu/drm/i2c/adv7511.c | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv751=
1.c
> > index 00416f23b5cb5f..85e994796d96a4 100644
> > --- a/drivers/gpu/drm/i2c/adv7511.c
> > +++ b/drivers/gpu/drm/i2c/adv7511.c
> > @@ -362,12 +362,19 @@ static void adv7511_power_on(struct adv7511 *adv7=
511)
> >  {
> >  	adv7511->current_edid_segment =3D -1;
> >=20
> > -	regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
> > -		     ADV7511_INT0_EDID_READY);
> > -	regmap_write(adv7511->regmap, ADV7511_REG_INT(1),
> > -		     ADV7511_INT1_DDC_ERROR);
> >  	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
> >  			   ADV7511_POWER_POWER_DOWN, 0);
> > +	if (adv7511->i2c_main->irq) {
> > +		/*
> > +		 * Documentation says the INT_ENABLE registers are reset in
> > +		 * POWER_DOWN mode. My tests with a 7511w show something else
> > +		 * but let's stick to the documentation.
>=20
> This contradicts the commit message, which one is correct ?

As Geert mentioned, the commit message refers to the interrupt flags not
the interrupt_enable flags.

Shall I rephrase?


--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWipnNAAoJEBQN5MwUoCm21D4P/iZb2jU+KD1CyM76U/u01oni
1ShXXQAky/WVuOrylaAIVvZv2q9N7eyJTOXxPm4Vws75TAzKWU7qhzp61TZ0bPCy
SdlbmSJdrPqIZrmVtYNLtAO6TvM+Oc877UmzMzXoOcrWiEMajVv3v7T3Ao/7N6bb
2Pr8gtB1GthPIb3sYDibG3lpOyi8IZo4ScfSmSYxfqqoJaJsy7j8LHQ35+5WWMBB
ueeZCQ3c8F40ZoIN8vdleZkVJdTWdw0JJ4Bt+JlDbK85bNcvg3agoUL5hL3EM4QC
FsHq6ih5zr1aQIOrX37WBho9QAWaSrjWCCLwaw63SDb9KquT8YKb67Vnb6jA7fhs
lXjEL7z7Iq0sjNnC6NsmRNlJYKReVZNgKFdyLV4LxQr6cKC1oa2O4StnSn93sopU
ryBxo8HazFEtjORsx21CTstb6n21PrevCGEgvl8F7vZ/YIVXBw1CtnZbQB+VuiRg
1KER9KC+bTau40/vy5iFPF9igZbITRFpp3tvFOZ6Znnc+5cy8ZKxnRDaAYPhKpYY
2y8enQe9133hW0aNM2/pAbuZs7KWobGT4KC2s4wTetaUOnCeY5wjfdLeSOdGvcMW
ZqOzEbQC4mQ9FZ/m1tUmFnKQxNkDQBJOSPj6A3MswXVigM22W0wLLbtuUJYT1pBh
eSgCUgv5vaojqOaJwHKp
=6Ecu
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
