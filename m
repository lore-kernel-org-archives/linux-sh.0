From: Felipe Balbi <balbi@ti.com>
Date: Tue, 14 Oct 2014 14:30:07 +0000
Subject: Re: [PATCH] usb: host: xhci-plat: fix suspend/resume on xhci-rcar
Message-Id: <20141014143007.GA18747@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
List-Id: <linux-sh.vger.kernel.org>
References: <1412829947-736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412829947-736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2014 at 09:29:18AM +0900, Yoshihiro Shimoda wrote:
> Hi,
>=20
> (2014/10/09 23:14), Felipe Balbi wrote:
> > On Thu, Oct 09, 2014 at 01:45:47PM +0900, Yoshihiro Shimoda wrote:
> >> This patch fixes an issue that suspend/resume cannot work correctly
> >> on xhci-rcar because the xhci driver output the following log:
> >>
> >>         xhci-hcd ee000000.usb: WARN: xHC CMD_RUN timeout
> >>
> >> So, this patch adds to set the XHCI_SLOW_SUSPEND quirk if xhci-rcar.
> >=20
> > do you have erratum number confirming this is needed for your platform ?
>=20
> At the moment, I don't have such number... I just tested it on my platfor=
m.
> And, the handshake in xhci_suspend needs about 80 ms...
> Anyway, I will ask platform team about this behavior.

alright, let's wait for your update here, then.

--=20
balbi

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPTNvAAoJEIaOsuA1yqREmyQP/RB1phg987Kk78K3K/NW9Ihx
JPqnUXULrqXRAfHgFmaMuGQKUmks54d8zXdf4WUuEvyQ+0tNNrvhyxUsvPlG3L0s
4EowYC40YiNDZ+sDbMwjEN9HuaEMh4X96vBYqfreXSereWyyndCkiWxcQW6h3pk+
5KdeOOUOCgjzmzGDRXOW9CqFjvuvVeDQgb9N0lc+1zdEJufiELYEVJZeK/sSUo89
Ya23oXB4TSxIxKyB3DGBg+wB9CTyWug2cl1BEhlhnypTJKnPB4d9KgKWprT8oMIj
IXJR6Be6y2kKe/Jg3OCb57VG7tvVWfwas4XpcKJjsLeCP9HT5RBZ+dQvN3FdIPHB
yONfVphET3jgEpOpMVqNAsjIMG5uAN8RXilPgbN2RFcuOoB1SuXHL9vwvv4GcMXp
qGslQqKfPRk7H9Ic1g6eWaMXFaTtdELR4R5BxhLU87Y+oy6VGwzJwT7TPDWi48vw
xD989GpCdpBphOe9sx2ceW+c3QeXA8q1oh+0X+SOsDZNKbcFx1hs8AFkQ1MXTEd2
xMPpPxiuLVeoGzAh/Ar23C6+0XW7v2zWjH79E2vTkbs8szMlN+at5/7wyBmzJoV6
I/fPCqgOY5nzoFGnFS9xCo96ZlXtCmq4MTCg11n7BzAb34xbf1IlZgQOrBUgb1rD
jUV5OkUhBtRWASrq3T3j
=ofct
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
