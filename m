From: Felipe Balbi <balbi@ti.com>
Date: Mon, 09 Dec 2013 20:59:19 +0000
Subject: Re: [PATCH V2] usb: phy: R-Car Gen2: Use usb_add_phy_dev
Message-Id: <20131209205919.GB29143@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7qSK/uQB79J36Y4o"
List-Id: <linux-sh.vger.kernel.org>
References: <1386618033-27670-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386618033-27670-1-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2013 at 12:32:37PM -0800, Greg Kroah-Hartman wrote:
> On Tue, Dec 10, 2013 at 12:16:13AM +0400, Valentine wrote:
> > On 12/09/2013 11:41 PM, Felipe Balbi wrote:
> > > Hi,
> > >
> > > On Mon, Dec 09, 2013 at 11:40:33PM +0400, Valentine Barshak wrote:
> > >> Use usb_add_phy_dev instead of usb_add_phy, so that devices can
> > >> be bound to the phy. This is needed to set up USB phy for
> > >> some internal PCI USB host controllers on R-Car Gen2.
> > >>
> > >> Changes from previous version:
> > >> * Fixed function names in the commit log
> > >>
> > >> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.c=
om>
> > >
> > > Was this a regression on v3.13 or can it wait for v3.14 ?
> > >
> >=20
> > I hope it's OK to have it on 3.13.
> >=20
> > The major reason for the change is to use the USB HCD phy handling
> > updates that are available now in the usb-next branch of Greg's tree:
> > commit 1ae5799ef6: usb: hcd: Initialize USB phy if needed
>=20
> But that patch isn't going to Linus until 3.14, so this has to wait
> until then as well.

3.14 it is, thanks

--=20
balbi

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSpi8nAAoJEIaOsuA1yqREgDcP/jSrJvCX5krRkFOqh5TkAGu3
8nZjExzaarzoq7qiblD6pEu9PBGFoyQHr2IKs1SA9fh30HbiT+MSTdhDz7+zVUU7
QMpr/bsQFdaTo4gUqotA22352YdqtcWb5rYhWjy0LKaHPy5sLtKraelsWa8EOV/2
yY90ScqvYDe/xu6FycS1lOWq7mTQx2d+NFbEHMsPBm6jkJIPq3DnghsTGz9LJWoq
ff+AChZreGN5WebgRt9z8JZ3pwuT8XDKz75wv7kQVn7GNv1T+gZ7eDIF8d9faqFZ
LnAmkfwWvwEc1VZTckrNaWq/Flo/8P1SsARfY1mwszuZPjz0pTFc/EQ0lOSH4dHV
ZTHljJ2WWO5iBXORZ/ymaD+2xlAP3cU2jT1JK9IyKKalkan/4FY5E1usDNlzQSl8
WpWX+dSfHcoxs+L6QZkNXaYuCbcK0wvYoEmzWmjwbx3W6UlXfYu/oHGrresh/qvW
7s0U9CXxVftitRsk9WI0B6poqg3mqwijJI70znkQb+jclKXwQDmSRT3bTy0Sz7ZG
sbMqJqofFGZ4SfECrX1KU43+QWiOZgNgbfMfV8FOHDoXTW7+KsqxLI/pr7YsxOCV
TImYA6q3iZvfFkz4F+f8o/WpIn+2twjG1uEqLxBcPrIXM8H5TbHJ/gEymSzOMf10
qulWVPOMD7bcQs8B95+K
=xaPa
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
