From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 18 Apr 2012 09:06:36 +0000
Subject: Re: [PATCH forward] ASoC: fsi: update for dmaengine prep_slave_sg fallout.
Message-Id: <20120418090636.GD3021@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2iBwrppp/7QCDedR"
List-Id: <linux-sh.vger.kernel.org>
References: <20120330082058.GE26543@linux-sh.org>
 <8762dj9fa4.wl%kuninori.morimoto.gx@renesas.com>
 <87sjg45h50.wl%kuninori.morimoto.gx@renesas.com>
 <20120416082702.GC3238@opensource.wolfsonmicro.com>
 <20120416121044.GD7368@linux-sh.org>
 <20120416121724.GA3219@opensource.wolfsonmicro.com>
 <87r4vl4wk2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4vl4wk2.wl%kuninori.morimoto.gx@renesas.com>
To: kuninori.morimoto.gx@renesas.com
Cc: Paul Mundt <lethal@linux-sh.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-sh@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 07:13:04PM -0700, kuninori.morimoto.gx@renesas.com =
wrote:
>=20
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> Nothing happened on ALSA ML.
> So I forward this patch.
> I added my Acked-by on it.

I've applied this since I can see Paul's original version in the archive
but when forwarding patches for someone else you should sign off rather
than ack the patch - signoff is mostly a statement saying "I know this
is OK legally" and so everyone who forwards the patch is supposed to add
one.

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjoP6AAoJEBus8iNuMP3doMsQAJwWF5zogXBeKBRCcRv8PKPf
hN49MhdkET/v9j3ompQQRQrtu2lmHEsd77wIAE6er7Q8O4txiRsSW89H/DF6LUHT
k35zLi4cA8rFoiGRTiw2eGmM+CgToFYVBvvcHAB/wfw6zTDa6eSYvQBE4SoKF16i
S/EQboofvT1bQwdTDaJvrQnJFHUe17KcdPdFVr5ur0+8iETWYnVeewajbdap1DYB
ovQC29OVzkLNHMJVQDxUEZhYAFsqvddskRcGA1uVHW67CKxzbuCVURGb8uGL1lWm
rMeBFc/DM7x+s73D4eWhfp2eevotq60U6XZmei55TNaQNYqnn0ato4+dmyKfdH/f
w1mjOCEudzwX/jxFaVibCId6pDoqChi9odONQdaQ9UQhOKBmazxXKRfKB/U8mhTj
NIoNxc8tMC5iKekxgQLJd/94ZyK7V771t7NHJZp3wq8VBAziF1Vl5B92Ew40YQrw
FOQG2kbfrLbC4SzyzWU9UA0YsOU8O+0TN+lHpWni7SMPgSIruzMtpxxWTCduTbM3
fP/K7uyaQHEWCUaRtDPJ2JHNceyPEunYJwPQSp+fT27FYPX/xAimVnZYUtINqEMJ
s1UZ9QuvuF1hJMwNmIzJfR8S1H4Zwrn0CXmLJk1A2R47k5tgCJGQ/lbU1UUPMTsp
cZvB4NUM/s1duDlm644N
=H8F2
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
