From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 24 Oct 2014 04:43:55 +0000
Subject: RE: [PATCH] ARM: shmobile: add USB3.0 device node on r8a7791
Message-Id: <c7fdc1369aa14de7a4b1cde5db6a43ff@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412749498-2748-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <5434D96B.4030304@renesas.com> <20141024042030.GC11281@verge.net.au>
In-Reply-To: <20141024042030.GC11281-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: "magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Simon-san,

> On Wed, Oct 08, 2014 at 03:27:55PM +0900, Yoshihiro Shimoda wrote:
> > (2014/10/08 15:24), Yoshihiro Shimoda wrote:
> > >  This patch is based on Simon's renesas.git branch and
> > > renesas-devel-20141007-v3.17 tag.
> > > Since koelsch and henninger doesn't have a USB3.0 connector, I
> > > submit a patch for r8a7791.dtsi only.
> > >
> > > Yoshihiro Shimoda (1):
> > >   ARM: shmobile: r8a7791: add USB3.0 device node
> > >
> > >  arch/arm/boot/dts/r8a7791.dtsi |   10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> >
> > Oops, this patch means [PATCH 0/1]...
> > Also the "[PATCH] ARM: shmobile: r8a7791: add USB3.0 device node"
> > email means [PATCH 1/1].
> 
> Hi Shimoda-san,
> 
> could you update me on the status of this patch.
> Should I queue it up?

Yes.
So, should I rebase this patch on the current your repository?

Best regards,
Yoshihiro Shimoda

