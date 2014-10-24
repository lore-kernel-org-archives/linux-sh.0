From: Simon Horman <horms@verge.net.au>
Date: Fri, 24 Oct 2014 05:08:40 +0000
Subject: Re: [PATCH] ARM: shmobile: add USB3.0 device node on r8a7791
Message-Id: <20141024050840.GG7537@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1412749498-2748-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <5434D96B.4030304@renesas.com>
 <20141024042030.GC11281@verge.net.au>
 <c7fdc1369aa14de7a4b1cde5db6a43ff@HKNPR06MB322.apcprd06.prod.outlook.com>
In-Reply-To: <c7fdc1369aa14de7a4b1cde5db6a43ff@HKNPR06MB322.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Fri, Oct 24, 2014 at 04:43:55AM +0000, yoshihiro shimoda wrote:
> Hi Simon-san,
> 
> > On Wed, Oct 08, 2014 at 03:27:55PM +0900, Yoshihiro Shimoda wrote:
> > > (2014/10/08 15:24), Yoshihiro Shimoda wrote:
> > > >  This patch is based on Simon's renesas.git branch and
> > > > renesas-devel-20141007-v3.17 tag.
> > > > Since koelsch and henninger doesn't have a USB3.0 connector, I
> > > > submit a patch for r8a7791.dtsi only.
> > > >
> > > > Yoshihiro Shimoda (1):
> > > >   ARM: shmobile: r8a7791: add USB3.0 device node
> > > >
> > > >  arch/arm/boot/dts/r8a7791.dtsi |   10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > >
> > > Oops, this patch means [PATCH 0/1]...
> > > Also the "[PATCH] ARM: shmobile: r8a7791: add USB3.0 device node"
> > > email means [PATCH 1/1].
> > 
> > Hi Shimoda-san,
> > 
> > could you update me on the status of this patch.
> > Should I queue it up?
> 
> Yes.
> So, should I rebase this patch on the current your repository?

Yes, please rebase it on renesas-devel-20141024-v3.18-rc1

