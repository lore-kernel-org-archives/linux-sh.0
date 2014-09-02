From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 02 Sep 2014 17:45:48 +0000
Subject: Re: [PATCH v2] Revert "i2c: rcar: remove spinlock"
Message-Id: <20140902174548.GB10355@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="V0207lvV8h4k8FAm"
List-Id: <linux-sh.vger.kernel.org>
References: <1642788.pEhrsPDp4u@wasted.cogentembedded.com>
 <20140824064520.GA2578@katana>
 <53F9CCE7.3010006@cogentembedded.com>
 <20140825034009.GA2795@katana>
 <53FB1F90.6080704@cogentembedded.com>
 <20140825143316.GA1285@katana>
 <5405FAD3.90403@cogentembedded.com>
 <20140902171835.GA10355@katana>
 <5405FE27.4050909@cogentembedded.com>
In-Reply-To: <5405FE27.4050909@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >I don't see why. If we have two patches, the state inbetween them is
> >broken.
>=20
>    Even so, it has always been broken, we don't make it more broken by
> reverting your change.

Yes. Still, if I send something to *stable*, less broken is not an
option for me, if I know there is a fix possible. And we are at -rc3
now, so there is still time for that.

> >And we don't have two patches yet, just the revert. So, the
>=20
>    I'm going to consider the spinlock issue ASAP, after I check whether t=
he
> I2C clock frequency really has any influence on the unexpected read NACK
> issue I've been chasing for several days.

Good luck with that! Such bugs are truly annoying :(

>    Your patch removing the spinlock went into 3.16 only but we'd have to
> backport the assumed single patch to the -stable kernels older than that.
> This means that I'd have to provide the "delta" patch (i.e. the separate
> patch that I'd like to provide now atop of the revert) for these kernels
> instead since the original single patch wouldn't apply anyway.

With all my changes in 3.16, I wonder if the patch with your addition to
the revert will apply anyhow. But, okay, you send two patches, and I
will decide how I apply them and deal with delta-patches. Okay?

All the best,

   Wolfram


--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBgJMAAoJEBQN5MwUoCm2xz0QAJ4Hnk4jvg9+MqWyW4boFMO1
Zeis0ZbMHBLOnoIlE6FPBUU1tJhCbZ0PNcbrCRiyDwcrsC3dRRIWxC7W1Zz0CNfW
hPFujc6pOYCLC0XQHFpmy4ylbJ9ASmEhMT3tdDr0izobeXR2tfmupgDpnywKWOgF
uf9Hc6vuiHVyBjI27Mou5WXblyR/EeyP5ZTPZzjV6a4dAJqJ/TqDg+2j0Z1PVNJg
Qp0sfb4CjFAs4zaC5BhOf7g6YebDzuMYHIGaikB1JBmHyMutt1ezZ6twZp3MhxoL
j1T4kGyqR7eK4tNM81Dk8el4aad4m1IvOYmh3/BP1pVEh0EcsqbTY1TjtDgxj3Go
lHCOUotyakaw76Kup8mckYKXxuDIUe7FK5QMrEwNmWw4+/uyID9rz5FPYq3ZPVld
y3TEtF2OFm9x1NzWrMWRCMwxCtnrLaIkbyZro+gas4pgYu4MiiY1DBuHNeJrcIuU
HjTl52vQ6K84sI6gQzT6c96wmB1ajVp+hTsQDXpYL3E33GdKmXZPZaiBlRT7Sp1Z
OJ8Nn6gj4SznMOVsl5fTq+Bh1Iqm7domf3r8pNc2fH6AlYTWT/3MIkiTOAEWOYu+
GIwP99Ox6C8AecyMht2x/wRKFDZrNa1v1qZiY/CeC+JodJt9lXZVjhc40TVs4H/2
+HIVK9TuMRSvxJLMAz9Q
=FWlS
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
