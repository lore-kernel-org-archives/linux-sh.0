From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 22 Oct 2015 11:09:11 +0000
Subject: RE: [PATCH v2 1/6] usb: host: xhci: add a platform-private pointer field
Message-Id: <SG2PR06MB0919426AA7F489498FD9B051D8270@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444217938-4668-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1444217938-4668-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Greg,

> From: Yoshihiro Shimoda
> Sent: Monday, October 19, 2015 6:11 PM
>=20
> Hi Greg,
>=20
> > Sent: Saturday, October 17, 2015 3:38 PM
> >
> > On Wed, Oct 07, 2015 at 08:38:53PM +0900, Yoshihiro Shimoda wrote:
> > > This patch adds an xhci->priv field for storing the of_device_id.data
> > > pointer. This will simplify the code to match platform specific
> > > variables (e.g. platform type and firmware name).
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  drivers/usb/host/xhci.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > > index 51093df..da227ba 100644
> > > --- a/drivers/usb/host/xhci.h
> > > +++ b/drivers/usb/host/xhci.h
> > > @@ -1653,6 +1653,9 @@ struct xhci_hcd {
> > >  	u32			port_status_u0;
> > >  /* Compliance Mode Timer Triggered every 2 seconds */
> > >  #define COMP_MODE_RCVRY_MSECS 2000
> > > +
> > > +	/* Store of_device_id.data pointer as xhci-plat private data */
> > > +	const void		*priv;
> > >  };
> >
> > Why can't we do what we do with the other *_hcd structures and pad out
> > the end of the structure as needed with the following:
> > 	/* platform-specific data -- must come last */
> > 	unsigned long           priv[0] __aligned(sizeof(s64));
> >
> > and then ask for the requested amount of space depending on the platform
> > being used?
>=20
> Since I found the following comment from Thomas before I submitted,
> I didn't add such the other *_hcd structures to avoid complicate.
> http://thread.gmane.org/gmane.linux.kernel/1697250/focuss028
> (This comment was written in last year though...)
>=20
> The current code has "extra_priv_size" like the following patch.
> So, can we add "priv" to xhci_hcd like the other *_hcd structures?
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=CD33a32157e42483ffea31e32b1cee4f11ff9592
>=20
> Anyway, I will investigate this "extra_priv_size".

I investgated this topic.
I found that the current code can add such the other *_hcd structures using=
 the "extra_priv_size".
(In other words, the comment from Thomas in last year is not fit with the c=
urrent xhci driver code.)

However, the current implementation is strange to me:
 - The hcd_priv_size in xhci.c is sizeof(struct xhci_hcd *).
 - The extra_priv_size in xhci-plat.c and xhci-pci are sizeof(struct xhci_h=
cd).

In this means, actual hcd_priv_size in the xhci driver is:
 sizeof(struct xhci_hcd) + sizeof(struct xhci_hcd *)

I don't think that the "+ sizeof(struct xhci_hcd *)" is needed.
Is my understanding correct? If so, I will fix this and add such a patch in=
to my v3 patch set.

Best regards,
Yoshihiro Shimoda

> Best regards,
> Yoshihiro Shimoda
>=20
> > thanks,
> >
> > greg k-h
