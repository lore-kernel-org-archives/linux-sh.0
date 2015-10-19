From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 19 Oct 2015 09:11:28 +0000
Subject: RE: [PATCH v2 1/6] usb: host: xhci: add a platform-private pointer field
Message-Id: <SG2PR06MB09193E6A14646F07BC95F875D83A0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444217938-4668-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1444217938-4668-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Greg,

> Sent: Saturday, October 17, 2015 3:38 PM
>=20
> On Wed, Oct 07, 2015 at 08:38:53PM +0900, Yoshihiro Shimoda wrote:
> > This patch adds an xhci->priv field for storing the of_device_id.data
> > pointer. This will simplify the code to match platform specific
> > variables (e.g. platform type and firmware name).
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/usb/host/xhci.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index 51093df..da227ba 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -1653,6 +1653,9 @@ struct xhci_hcd {
> >  	u32			port_status_u0;
> >  /* Compliance Mode Timer Triggered every 2 seconds */
> >  #define COMP_MODE_RCVRY_MSECS 2000
> > +
> > +	/* Store of_device_id.data pointer as xhci-plat private data */
> > +	const void		*priv;
> >  };
>=20
> Why can't we do what we do with the other *_hcd structures and pad out
> the end of the structure as needed with the following:
> 	/* platform-specific data -- must come last */
> 	unsigned long           priv[0] __aligned(sizeof(s64));
>=20
> and then ask for the requested amount of space depending on the platform
> being used?

Since I found the following comment from Thomas before I submitted,
I didn't add such the other *_hcd structures to avoid complicate.
http://thread.gmane.org/gmane.linux.kernel/1697250/focuss028
(This comment was written in last year though...)

The current code has "extra_priv_size" like the following patch.
So, can we add "priv" to xhci_hcd like the other *_hcd structures?
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=CD33a32157e42483ffea31e32b1cee4f11ff9592

Anyway, I will investigate this "extra_priv_size".

Best regards,
Yoshihiro Shimoda

> thanks,
>=20
> greg k-h
