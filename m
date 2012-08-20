From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Mon, 20 Aug 2012 09:19:35 +0000
Subject: Re: [PATCH] mtd: sh_flctl: Switch from tick-based to time-based timeout
Message-Id: <1345454375.2848.21.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-2RAvyhNkP3WAQkuM0X0c"
List-Id: <linux-sh.vger.kernel.org>
References: <1341410726-10562-1-git-send-email-hechtb@gmail.com>
 <CABYn4syMFh4smteHS-zCAy3ygKsyxoD2+FfaBeQxKvK_FA+5mA@mail.gmail.com>
In-Reply-To: <CABYn4syMFh4smteHS-zCAy3ygKsyxoD2+FfaBeQxKvK_FA+5mA@mail.gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Bastian Hecht <hechtb@gmail.com>, linux-mtd@lists.infradead.org, Linux-SH <linux-sh@vger.kernel.org>


--=-2RAvyhNkP3WAQkuM0X0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-07-25 at 17:21 +0200, Bastian Hecht wrote:
> Hello Artem!
>=20
> Could you please pull out this patch of your tree? While reworking the
> driver for IRQ-driven use, I've realized that this conversion makes no
> sense as all loops use a udelay(1) in them. So the timeout is already
> time based.

Dropped, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-2RAvyhNkP3WAQkuM0X0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQMgEnAAoJECmIfjd9wqK0FLwQALkvfvpQJUgo5e8zDrL3svYb
tO7gMRXSQE+HRWpwqmXBH+RRK89Ez6Hz8jRzj3N24uF7jqih6sWPU0g7tp2WA3ZW
xRgAbWwj/C0Qi+2dmYR8ClAbBaOQUgheIuvdcPqjQZuvkXwxGoUV/NqM7LvQDr+6
gibgte7wTPhs1QfiWDiJkQ3SQC2f4Xu0++/88LJvcHaqbaYADC//PSGE2EK2S4aw
X62JV2XNr664iTpIxCu3FcrJ+dhW0rBfwRFnbGXlN5mYCuFCesICLiSMo3iLh+X7
Ic7gCdOrwsWKfwJ2/bauRwUNqHAE4uezS7b9e/eHRTTTJYCa4BzkqXWOJwI5s6VA
fgz/le9n0a4F6jaLUI+E12glCfudvg3VbIl2sBbFj8vY99MLTJwLNL8Xy+iR//Jk
2Eac4mSHOVI5npdHew5H2Ycrkz+YXJDDjQOjTknbCUHxPe0Io0HLFKkntBy/XWGx
mC2y0F4h5ntrSsw0oOuab8WGkUSNcwZDVjXdkvLGWhD7Mjs9JQKz9iSx7LwCe1E5
xGa5kkRVUHI9iWQBt227ccAfn0QYU8Aw5RBlnMUnXSh0JuSFBNkk1Se5bhEg4cMa
cJ/Ezf1Kjk6JY0qkkhbfKcxhV5o9G8vkX7QuGlImmKr6pmOvbTFzV1xVo0muM7SC
8qtMU5zMf7dMxyrWhckp
=mw5T
-----END PGP SIGNATURE-----

--=-2RAvyhNkP3WAQkuM0X0c--

