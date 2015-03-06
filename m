From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 06 Mar 2015 22:18:09 +0000
Subject: Re: [PATCH/RFC] i2c: rcar: Support ACK by HW auto restart after NACK
Message-Id: <20150306221809.GB6572@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="H1spWtNR+x+ondvy"
List-Id: <linux-sh.vger.kernel.org>
References: <1424011480-3551-1-git-send-email-ykaneko0929@gmail.com>
 <2775fbb6b2e2b333ef2457133f419d4d@the-dreams.de>
 <20150304040635.GA12776@verge.net.au>
In-Reply-To: <20150304040635.GA12776-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >Even if R-Car I2C received NACK, after that it might receive ACK
> > >by HW auto restart. In case of that, driver would continue process.
> > >If R-Car I2C didn't receive ACK, the driver would detect timeout
> > >and would report NACK as -ENXIO.
> > >
> > >Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > >Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >=20
> > Excuse me, but what exactly is HW auto restart in this case? Is it a fe=
ature
> > of the I2C slave?
>=20
> I asked Kataoka-san about this and his response was as follows:
>=20
>     It is a feature of the i2c-rcar(H/W) master.
>=20
>     If system(CPU) is busy, NACK procedure may have interrupt latency.
>     Since the clear of ICMCR.ESG bit is delayed, i2c-rcar(H/W) may auto-r=
estart
>     after NACK. Please refer to ESG bit of H/W UM section 55.3.5.
>=20
>     For example, this is I2C write transmitting.
>     1.Start / 2.SlaveAddr,ACK / 3.RegAddr,ACK / 4.RegData,ACK / 5.Stop
>=20
>     If No.2 has NACK and interruption has delay, this transmitting is as =
follows.
>     1.Start / 2.SlaveAddr,NACK/ 1x.auto-restart / 2x.SlaveAddr,ACK
>                                     / 3.RegAddr,ACK / 4.RegData,ACK / 5.S=
top
>=20
>     NACK of No.2 is invalidated by ACK of No.2x. It means recover.

Does this make some I2C device work which did not work before?

Most I2C devices always ack their address, so NACK very often means
"nothing is there". I think it makes sense that the rcar driver returns
ENXIO in this case which is documented to be used for NACK after address
phase. Then, the i2c client driver should know if this means "not there"
or "currently busy". And it should know when is a good time for another
try. As I read the patch, the driver would use the auto-restart feature
until the timeout is reached. That would make bus scanning pretty slow,
too.


--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+iehAAoJEBQN5MwUoCm25j8P/1qENhruWt5vWc5wSjpE7jY8
l70UkRVSUrAH+SZvYNjrX11bSCvdJMY31GlKfKM8jfS50sEvFtou6lt4UGDXEM5h
MkHtuO1CpokRA63CnACXWKnweGdQXw6JfcRstYduhocXwNMMSz35bAtyVr54RwUT
euI/HrtIdvam36HYiZME/Jb9iTxwc9kqdFLVsegOhYuiX7O9ans/eAeQ/N336rl/
lm4AMfMx5mrRJNtj8A6PRE6AGHUSu1avEjUEzyGJKQmxbDoUOTw5BqhjV6zT7UUe
Vm5gKq9gz5RQablDWm+13dQFAZHkOq3LFdRVkFvOOdWOj3KJHUsDptjnncYsFUF7
3IQxf+id/SnTnCkSvW3++b+DK6AZNGSuGye0tJWXfyaYnxmXED1FHOTZl88bbVaG
cZ8L835GSteSlGtW5tvTydIZmcqzyN8y5JEJ9gpuRtXFJjeQlnJfyZ0KvLh2Fuc4
CwaBrm/Ic35ps4IL2oEhGJQyrdLso/yS3nt/VV7zv6AreXCe3pLebHXalBVagHoE
frhVWpcE+ScgfkoOKkFnMW2uleQXbknObinHKOQKDOBiFEwEfQB7eKzIj/GsQsb1
fdZmeP1/zay8q6XFsZh2VFiL3vRjULJJ4jOHhCrus7tWnwuL1L26QPGSyWC9flGN
42B9xsTzclbilw92AFaz
=av9Y
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
