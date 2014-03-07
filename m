From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Mar 2014 16:29:47 +0000
Subject: Re: [PATCH V3 00/12] CCF support for Renesas r7s72100
Message-Id: <20140307162946.GG28943@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uc35eWnScqDcQrv5"
List-Id: <linux-sh.vger.kernel.org>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <2368991.bjBJjms8qn@avalon>
In-Reply-To: <2368991.bjBJjms8qn@avalon>
To: linux-arm-kernel@lists.infradead.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

> Beside the comment to patch 06/12, I would have moved patches 06/12 to 08=
/12=20
> to the beginning of the series, in order to avoid adding a clock workarou=
nd=20
> for the serial clock only to remove it a couple of patches later.

That would have saved only 2 lines since we need the workaround anyhow
(MTU2) and would break the incremental approach of this series somewhat.
I'd like to keep it.

> Oh, and one might ask you to fix the 80 columns checkpatch warnings for p=
atch=20
> 01/12 :-)=20

Broken intentionally for the sake of readability :)

Thanks,

   Wolfram


--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTGfP6AAoJEBQN5MwUoCm2XY0P/RfAiBJ2zdblVQEqE0HhFoAY
yF9hGfWq0phLauDaYCxwqsMdI3egpxk1b/clS97VgapUHdJ+Zwy0p8S8P5tdCt/u
zFs08ajzd05Zl79NUloH53x2Oh2lRZS+7gNKE146GEIZsfbEOPV8hLa2djdQX9h6
QQ4hY3kUir4yf8TK6XU84n+eE1vAG7DsKP48Jzgezo6Xbdx2zJtbOGkL+aIvgGDX
rWRiZsNmeWmD4zTyNRr9q3aoVMwSCOLDMMx5RTqVsyoxQVWaeaURyDYapLCV/KYX
x//a7WBKkfdNxTkg1iFDec3FkzC6PQt+rr/DjheIOTOAnutSWBZkKGvxYbU+O7Kw
E0LmadSHmDuP9XiHOYit3QCHTtjxghAnDb0jqE1YS7+14Zp3blvjcK+btWw/CIoo
GPzXWBllxmulbS8ydB6KAcm0VUHGuAE9JozNMavywMQHF7b/KHwXQj0gYsLKIxsT
ZCYRi2SBAiVBolso2R7UyO1n93eUWWHhn5Tkwzct5GUlErMa4Uzbgi/b5gPXhGIS
djW/56po7WBvNJ87uxyCdyIw+k6kDBHpEeLzrFynh71QBiYjpaG3/UtMuKozdbzw
faYUZbrX1l1qbTjHOKS3V1ak8s7v0s+wdW2Dm+ladbFtWwi9oVAjgeyF9Xpj+y5F
XMsg2hdd93o1hMiafuII
=rizy
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
