From: Felipe Balbi <balbi@ti.com>
Date: Thu, 14 May 2015 06:47:06 +0000
Subject: Re: [PATCH] usb: renesas_usbhs: Add access control for INTSTS1 and INTENB1 register
Message-Id: <20150514064705.GB21644@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aVD9QWMuhilNxW9f"
List-Id: <linux-sh.vger.kernel.org>
References: <1420763321-4868-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1420763321-4868-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-sh@vger.kernel.org

--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2015 at 06:18:06AM +0000, Yoshihiro Shimoda wrote:
> Hi Felipe,
>=20
> > Sent: Friday, March 06, 2015 3:55 PM
> >=20
> > ping?
> >=20
> > (2015/01/16 19:10), yoshihiro shimoda wrote:
> > > Hi Iwamatsu-san,
> > >
> > >> INTSTS1 and INTENB1 register of renesas_usbhs can access only Host m=
ode.
> > >> This adds process of accessing INTSTS1 and INTENB1 only when renesas=
_usbhs
> > >> is Host mode.
> > >>
> > >> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.yj@renesas.com>
> > >
> > > Thank you for the patch.
> > >
> > > Acked-by: Yoshihiro Shimoda<yoshihiro.shimoda.uh@renesas.com>
> > >
> > > Best regards,
> > > Yoshihiro Shimoda
> > >
>=20
> Would you apply this patch to your testing/next branch?
> This patch is very old, but I could apply it to the latest testing/next b=
ranch.
> (commit id =3D 1c14905ef951fb968c8da90e4e64be02c309a2ae)

thanks for adding me to Cc list, I wasn't in Cc and ended up missing
this completely. Luckily I still have it in my inbox and will apply it
in the morning (it's 1:50 AM :-p)

regards

--=20
balbi

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVETpAAoJEIaOsuA1yqRE6ykP/3GvufTZrborF2uD0o4QhN5u
gtZ+hVThjfC8R8rdcRu56iGAqqObBN+e0C0PMlqey5auiDz7nszQiqtCQ6vKnfYH
swmoxUPkwVsgVq/r7yt0xQRkhHzYuEc++gHVMQbR/0eBhl28YXy5mP7PUiolhES0
ZEX43wf6OnlEJjP7XaRXcNvs8ZEIQGjkEnNwjBU0iLJ89fVIUmK4RxcTus+ZEonw
pCLxNViYIITJG5W9YIQfzQJWUTE9Tewvudpqj8UUQHbncd4AFyx7/mCOtU2v8dpg
VorOwfLTBatjGo1uB3yAocJ2iOniGwQ2kteN+Hs+KOBNNACPfy/eIsc//5L20Yju
C0/LvJkSMgDv0+lpKzgAr79IUhubkQpP2/v5JRc19y5XmNh8GoceYSSTrki3Q9uH
Kb3668hnSAIicSvXle5YiBWOzhQiDneINZ9M5j8DbmAeUgTVbLrcQrq3zudmfnKp
i8v8RsT9/MkOO8ZjYL2PJoisOkMPg0nYAo5eYvYAmHjjlTTw1MpIfNVOyZlJiuj7
MUPCCd3jrWEU+y3CDTzXxNPPsYUM7VUECv+3C6bcvg10RXNl11N9tbdsOfkzcAJ/
383md3/HhpGmhIu+ztnaue9v4V7X+bTjTXeSPqro8+m9UXgmM+dl6QQGuKADl7L6
OulYx70fLNdUuQiCyZ0j
=Utg4
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
