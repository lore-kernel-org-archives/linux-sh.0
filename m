From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Sep 2014 13:51:13 +0000
Subject: Re: [PATCH 4/4] usb: renesas_usbhs: fix usbhs_pipe_clear() for DCP PIPE
Message-Id: <20140910135113.GG667@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5L6AZ1aJH5mDrqCQ"
List-Id: <linux-sh.vger.kernel.org>
References: <54102925.10808@renesas.com>
In-Reply-To: <54102925.10808@renesas.com>
To: linux-sh@vger.kernel.org

--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2014 at 07:34:13PM +0900, Yoshihiro Shimoda wrote:
> Since the DCPCTR doesn't have the ACLRM bit, the usbus_pipe_clear()
> should not call the usbhsp_pipectrl_set() with ACLRM.
> So, this patch fixes this issue to add the usbhs_fifo_clear_dcp()
> in fifo.c because the controller needs the CFIFO to clear the
> DCP PIPE.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

which commit does this one fix ? Do we need to cc stable ?

--=20
balbi

--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEFdRAAoJEIaOsuA1yqREnbQP/1453+FOXEGZHsT/Ssxk9tLZ
MMwfBLVEXOcKRev/q6T8KkBANmz1Jhj8iFznWEL27GLdfBho8sNIoQ1JB1SVVmsq
vGIQLLefXDGUckYJFuIrZ0hXm4Td5YQIasQBnBInYiwduQnFylzUhIhzJc3SjpXq
4xLYnRslobvOgt1MczP5aBrBDZPd030wQUU1ckRcQHp39ullF6sqIFnqvLEpS85h
9vTwNlNyX2XImSduE9BGLR5UlnwLuZPtuy6lFdDuANyXZda55kHkOO8HzrcEoJ15
RL0TI398QQ5B2EeRSrQN4XmJ7BgzO/mH438OKlBhZgpAWhNGwvrZudKMRp6hvpUb
0tuj9h9NwaAy9nd0rgf7HLfFG2yzwdvau/610NtteusWkU5RnlM/DQ2s3Dak5mlm
FLA/rerKQNrI+Piz9vVfHJ6z6gWtWmCT1ZE0JyATLrFc86EM2xt0CpTpu7qULDpz
lckzEFNXpYn05z+aIIftQ6OyttmkKPtKGTQvwxZrcP8c+sluyScgHxXQkGwUm1vd
6+CeCPMTAo92dlYuQZWQ/sRyLOQ1YT//nlJ8DLwR9QbMA/4JkouCiU4kh7FlygCI
BcW4oWlzn0yfBKeKFYH3q+eMmkHludT5wDia2zMVlxLGd/t/lHou390KkVceO9N7
1VK4nbw3cWR/NEkC5bDK
=DaSn
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
