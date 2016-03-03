From: Felipe Balbi <balbi@kernel.org>
Date: Thu, 03 Mar 2016 09:21:46 +0000
Subject: RE: [PATCH] usb: renesas_usbhs: gadget: fix giveback status code in usbhsg_pipe_disable()
Message-Id: <877fhj9as5.fsf@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <1451042763-4648-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1451042763-4648-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Yoshihiro,

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> writes:
> [ text/plain ]
> Hi Felipe,
>
> Oops, I completely forgot this patch.
> Would you review this patch? Or should I resend it?
> I confirmed that this patch could be applied on your latest
> testing/fixes branch.

I don't seem to have the original patch in my inbox. Would you mind
resending ?

Thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2AIrAAoJEIaOsuA1yqREddIQAJ2GmxG/4eyH5a6XNeI4jLf0
nW1ROqeoMEO9XFe8Pgw8eEiyTQakYSE/WTawdSvymAWvqQN0c+M2m5D8Lso23o/T
W5yZMyxuA+33GSLzr12SfFkftKgz/rQt4xOfx20syQbi6PW68wCMlSHe12K0HifU
bN6BYGnDexx55vNzW3B5FHkexOfukADVhrHDdACmIV9gTEmFZuMgZo0L75pOGXqp
sz3P2fF3o5xO0t1eNcMoKmbNOE8on6JlEV0YGrBzJgTKeAb7HbqsmueVe0WXFJ49
ITl2HSIUybdmjH25KPu+KfYyhwnLEuZ3skWH+alkwNq2CKkfN26jLz9PZP4+8Y/D
rTUwciEQ32Uwypq/w277t+gaRJeUxbpEElns5d9WzE2uIUasW5D+552Ixn+iRf2R
3zbEgwhTDNE19cjB6GoPykWR7Ef24HddY8OGMoPzJxuQSVjkGNOdZDsiFjLWW/4O
Xx8sqBAknOpWpidvzztCqO770B0DP9uxnPcrnrbeyvzfrv5oaNINvxDKg6XrYxtT
VLYD7SzyF1Vcczu1XMYGyRJ/Kt4LnZ5AvqgAGFsZMOUh1TYmae5/+z6QFMyQaCJv
6nTY5QOG7HavjBwIAzfYPR9m5nfmbPLnXBK6Ufxbr9sJmxtG6Z/Vvot5z5nh/8Gr
5e2RUFF5SoDrhM4eW9TR
=kg1J
-----END PGP SIGNATURE-----
--=-=-=--
