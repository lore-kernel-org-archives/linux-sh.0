From: Felipe Balbi <balbi@ti.com>
Date: Fri, 30 Sep 2011 09:55:25 +0000
Subject: Re: [PATCH 2/2] usb: r8a66597-udc: add support for SUDMAC
Message-Id: <20110930095524.GA6455@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
List-Id: <linux-sh.vger.kernel.org>
References: <4E803B16.1090905@renesas.com>
In-Reply-To: <4E803B16.1090905@renesas.com>
To: linux-sh@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 30, 2011 at 06:49:15PM +0900, Yoshihiro Shimoda wrote:
> Hi,
> 2011/09/30 17:17, Felipe Balbi wrote:
> > Hi,
> >
> < snip >
> > On Mon, Sep 26, 2011 at 05:43:02PM +0900, Yoshihiro Shimoda wrote:
> >> @@ -186,6 +187,51 @@ static inline void control_reg_sqclr(struct r8a66=
597 *r8a66597, u16 pipenum)
> >>  		printk(KERN_ERR "unexpect pipe num(%d)\n", pipenum);
> >>  }
> >>
> >> +static void control_reg_sqset(struct r8a66597 *r8a66597, u16 pipenum)
> >> +{
> >> +	unsigned long offset;
> >> +
> >> +	pipe_stop(r8a66597, pipenum);
> >> +
> >> +	if (pipenum =3D=3D 0)
> >> +		r8a66597_bset(r8a66597, SQSET, DCPCTR);
> >> +	else if (pipenum < R8A66597_MAX_NUM_PIPE) {
> >> +		offset =3D get_pipectr_addr(pipenum);
> >> +		r8a66597_bset(r8a66597, SQSET, offset);
> >> +	} else
> >> +		printk(KERN_ERR "unexpect pipe num(%d)\n", pipenum);
> >=20
> > according to CodingStyle, if one branch as braces, all of them should
> > have. Also, try to avoid printk(), I guess you have a *dev here to use
> > dev_err(). Besides this, I guess it looks fine.
> >=20
>=20
> I knew the rule, but I mistook the code...
> I will fix it. And I also use dev_err() instead of printk().

it might also be wise to add a patch, before this one, converting
printk() to dev_* macros, I guess ;-)

--=20
balbi

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOhZIMAAoJEAv8Txj19kN10BMH/iDbdA5PC2wVygYIQ0dhdGd0
wB77emMTVIB2Fv1imVZM1pHbYKavt513uwCDOYMzsB2wvgBBRytR8Yd+sBsr/zSe
Z9N9PTTrF+oEjVR+3djv49bY5KbveRmDYLmeoRET3NvFgROl9ZEned74Bns7Cxdz
HZlIJW0dzIPK08LRQrVHMoGWaG+5WFWdawEio0Sj9a7pGjf0QQ26/r7y/dHyXxHn
5LQ5j8dMVWqeRhNcpKu4VWaKaA5Vgxd6wtxizMQPSO2ko1ITp3ohjPxryv8Cn7cu
29rws8RKoxEBVSOi3OansxYfvCGo4KBLfbo/PMz5sDGRWOTAHjF1n9qDif3uDgg=
=188G
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
