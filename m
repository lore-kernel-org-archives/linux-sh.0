From: Felipe Balbi <balbi@ti.com>
Date: Wed, 06 Nov 2013 17:04:44 +0000
Subject: Re: [RFC PATCH 1/2] usb: hcd: Remove USB phy if needed
Message-Id: <20131106170444.GR24322@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5FFaGRZUwcpbKFrw"
List-Id: <linux-sh.vger.kernel.org>
References: <1383683607-28119-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383683607-28119-2-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--5FFaGRZUwcpbKFrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 06, 2013 at 08:43:36PM +0400, Valentine wrote:
> On 11/06/2013 07:45 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Wed, Nov 06, 2013 at 12:33:26AM +0400, Valentine Barshak wrote:
> >>This adds remove_phy flag to the HCD structure. If the flag is
> >>set and if hcd->phy is valid, the phy is shutdown and released
> >>whenever usb_add_hcd fails or usb_hcd_remove is called.
> >>This can be used by the HCD drivers to auto-remove
> >>the external USB phy when it is no longer needed.
> >>
> >>Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>---
> >>  drivers/usb/core/hcd.c  | 14 +++++++++++++-
> >>  include/linux/usb/hcd.h |  1 +
> >>  2 files changed, 14 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> >>index d6a8d23..d939521 100644
> >>--- a/drivers/usb/core/hcd.c
> >>+++ b/drivers/usb/core/hcd.c
> >>@@ -43,6 +43,7 @@
> >>
> >>  #include <linux/usb.h>
> >>  #include <linux/usb/hcd.h>
> >>+#include <linux/usb/phy.h>
> >>
> >>  #include "usb.h"
> >>
> >>@@ -2611,7 +2612,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> >>  	 */
> >>  	if ((retval =3D hcd_buffer_create(hcd)) !=3D 0) {
> >>  		dev_dbg(hcd->self.controller, "pool alloc failed\n");
> >>-		return retval;
> >>+		goto err_remove_phy;
> >>  	}
> >>
> >>  	if ((retval =3D usb_register_bus(&hcd->self)) < 0)
> >>@@ -2742,6 +2743,12 @@ err_allocate_root_hub:
> >>  	usb_deregister_bus(&hcd->self);
> >>  err_register_bus:
> >>  	hcd_buffer_destroy(hcd);
> >>+err_remove_phy:
> >>+	if (hcd->remove_phy && hcd->phy) {
> >>+		usb_phy_shutdown(hcd->phy);
> >>+		usb_put_phy(hcd->phy);
> >>+		hcd->phy =3D NULL;
> >>+	}
> >
> >why do you need the flag at all ? If hcd->phy is valid, just casll
> >usb_phy_shutdown() followed by usb_put_phy(). Did you find any issues
> >with that ?
> >
>=20
> I haven't been able to test it with other platforms.
> However, some drivers use devm_usb_get_phy_dev() and we may face refcount=
er issues
> if we call usb_put_phy unconditionally.
> Adding this flag seems safe enough and we doesn't affect other drivers.

then use devm_usb_get_phy_dev() here and remove the call from all other
drivers ;-)

--=20
balbi

--5FFaGRZUwcpbKFrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSenasAAoJEIaOsuA1yqRExjUQAKXPS7Vf1fe9dEc5XZiVPLSp
U5uSFTQ3+huQMsUF31vHHMDmrZeeF2ZHEGvqqIA46YfkwCneMUiw3PG7Vsh5ss5U
A5yPHniwM2zokRmASNoo/fvQedsnLngHB1qBlE1qXEUNYgsv02dXV2bylDjue/ce
yCDUowexh92LCWOBeIF2lo3YJ9kwfKBEwToC8C9UQCnIq62Lwnbd8oqL+tAv9o8v
4wltMf0j3+/f4HBT6brcR2E4+KRMAHBjxt10UolCDwp7M4v/M3b2Fks4LVa3Fvci
N+BLHp3ouNvoE96caDIJF66OjSXUA4zShvzkurOYjJgm81VIJ1B6rI4/DxjlSMck
cgUMOtnpmP87brvbLgqAKa7uXBv2sRpJBPtqGgWD6TCzHMMs85Hr3AciRvZ7Cd2S
TmxpSTc9uIOh7xCZadr+K7FnW4yobk2AqRGIjic1s/AIbe4/y+vC+HgsCX3EcV4R
iNAvEHRlWb+5ZZrkyLu3gEv639SrNojClrjUxx1/LzgEHtj6MJY2Y3BpWeD41H6v
nu/IanmWs+P1DwuB1mWf1/I1TIhddZa1mMgzbwAJQFimvf3ybbDRJ/07SCQLsL9R
t91eljqMOIFQ0nRG7hBxEya83JaU4PyRZ4eweKFoLzVGCGobiInytrKVL9XN5c1H
p9aQQFu6IOQWRFS3RT1w
=UjMt
-----END PGP SIGNATURE-----

--5FFaGRZUwcpbKFrw--
