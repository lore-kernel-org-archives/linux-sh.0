From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 01 May 2014 16:50:22 +0000
Subject: Re: [RFC] i2c: sh_mobile: WIP! Fix clock calculation for newer SoCs
Message-Id: <20140501165019.GA2602@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
List-Id: <linux-sh.vger.kernel.org>
References: <1398945555-12928-1-git-send-email-wsa@the-dreams.de>
 <CAMuHMdUVCP-dwJ-HMD1xHb9qR_qm-n0YTpYVq9w37DvD=E=X=w@mail.gmail.com>
In-Reply-To: <CAMuHMdUVCP-dwJ-HMD1xHb9qR_qm-n0YTpYVq9w37DvD=E=X=w@mail.gmail.com>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 03:26:15PM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Thu, May 1, 2014 at 1:59 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > +static const struct of_device_id sh_mobile_i2c_dt_ids[] =3D {
> > +       { .compatible =3D "renesas,rmobile-iic", .data =3D (void *)1 },
> > +       { .compatible =3D "renesas,iic-r8a7790", .data =3D (void *)2 },
> > +       { .compatible =3D "renesas,iic-r8a7791", .data =3D (void *)2 },
> > +       {},
> > +};
> > +MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
>=20
> > +               const struct of_device_id *match;
> > +
> > +               match =3D of_match_device(sh_mobile_i2c_dt_ids, &dev->d=
ev);
> > +               pd->clks_per_count =3D match->data;
>=20
> Missing cast "(int)match->data"?

"This patch still needs some improvements, but already shows what I am
aiming for." :)


--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTYntLAAoJEBQN5MwUoCm2XXMQAIGtc24Bid2zkrLhkjb6GPvq
jNSWS7zsnCF7ZhI9NePzOLbNUAmJiNKORfT7A69bLHuPgIcEUyUCfM8SvrBjnnvF
AdHFKksubfINa2oV+qG+FrdSjHzLBsl5qTKBfNdTGW+wZWykhg/xxagHerH1ZjQg
w98usBltw0gGWxRa/75fYAh9edJOLz6EvDso+JMcVNJG/vWlpSQRagh2L66guwaq
2n8D0sLPDfmpbQTsZi3lHvWLAnAfhhxGCOVPlTkkip/d4rM/wTi1CNlTS3oL9fiQ
hVTb2Z7hiTayCOEMIlHYyLKHGKXNteGBJH8a0iUDfHjRlKwsKlupu2fsuUMkZ5wA
cyf1RRS90kE2dAam32HagINrxMQZbGOcFJ9vgz/sazdtwZr/m7I/wVR2dyeEEIUr
qQYFqG5xdzbnkGYZTPTcTxFpMHhvzIa3Ju1+9cNo/CrMZxXQOAe0U1ShDVnn2zVF
jxHfQKlxxUJ9/Zh6ZM/WC5oEtAUlLrhLzErugMXitThhDItm0Cc89+8Y/J8SDYRf
+XBZeKPfqkUkGAwDT9jogmUMUl6gKi+6n4eOOa5tQXmufKPgfoXznNq1ZkY3cjm0
kCTOjyQQ2/lBgVcBDWH5LLK5mQK4sMvlrHndZ/Q5P2umksrC4jha1DPnjC7nmosh
Kg3jZ0mNGq8n1LQTZc50
=kgqS
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
