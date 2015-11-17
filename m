From: Felipe Balbi <balbi@ti.com>
Date: Tue, 17 Nov 2015 15:31:36 +0000
Subject: Re: [PATCH 1/3] usb: renesas_usbhs: gadget: Fix NULL pointer dereference in usbhsg_ep_dequeue()
Message-Id: <87y4dwk5gn.fsf@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <1447307130-6072-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1447307130-6072-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> writes:
> This patch fixes an issue that NULL pointer dereference happens when
> a gadget driver calls usb_ep_dequeue() after usb_ep_disable().
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

and which gadget driver is that ? Let's fix it. We should _not_ call
usb_ep_dequeue() after usb_ep_disable().

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWS0hZAAoJEIaOsuA1yqREeGgQAJfavm6kWfQOMVwqZjQKtLnw
GRgwgEk4R6l6BsrRJc7kSSo8p5ylYb2jgBmCtqa5YrQhOlmE21TU3iLp8Tm/juho
ro9WLEuVzElywCfuKMY2qlJK8OceVgqWks2+9mdtnJAPmaWX+u20XW0WvP/Pk7dm
rbh6Uhf2+d0taXCHqGbudgIR7idu4uCqyWr5uHJ2ncx0nujnnoN2H5U0qLTE0z13
iSzPShoCIEwDOoLIbeH1Jcpeh2QE+qDDjKstw0tlgEgDuf9+5pmXVxWjzhHd38Wf
1N631ia1pvKpMqMNmZgpuSXe97E1Lthi0TvxbejX8fTx46g7WcNZIW1txZCeZlNb
vdHHPry4NNpcYrGK7p5bsA8llTsoYmiv6dNWarD3+JiOcbQvyh0DswIu0PMNjhls
RXOF+KqZ6E9HFIGvj1bRjJ1cyDtv4FyaFq4Kz4HpwqIwUGHuq2alP2Y1Vfv0jaGu
pRclUfNQkh6FON8QiroxDmOaQ6iCAN63OnvKGNtRqFKMnungeOYp2iwR4FWxpw58
sLNGWK7zk6cGhfavV1he+ONWv72VYw4D/53ICVuIGcZDJ0iK+Lqb8hxhUeraRoKR
DIh1suZPubqongJrd210fekRv1SbrD293jSfXCgcm8UPA56gAL8HF49oCRq7dc5I
f7dBFDmdwgkaXgJkQUTI
=t7Sa
-----END PGP SIGNATURE-----
--=-=-=--
