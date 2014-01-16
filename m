From: Simon Horman <horms@verge.net.au>
Date: Thu, 16 Jan 2014 06:59:24 +0000
Subject: Re: [PATCH 0/2] ARM: dts: Add SATA to R8A7791 Koelsch device tree
Message-Id: <20140116065921.GC15366@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389719131-24376-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389719131-24376-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Jan 16, 2014 at 03:47:27PM +0900, Magnus Damm wrote:
> On Wed, Jan 15, 2014 at 2:05 AM, Valentine Barshak
> <valentine.barshak@cogentembedded.com> wrote:
> > This adds SATA nodes to r8a7791.dtsi and enables SATA0 in r8a7791-koels=
ch.dts.
> > In order for this to work the following patches are also needed:
> > * R-Car Gen2 SATA phy support:
> > https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3D=
for-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
> > * a couple of MSTP clock fixes:
> > http://marc.info/?l=3Dlinux-sh&m=138823255807611&w=3D2
> >
> > Valentine Barshak (2):
> >   ARM: dts: r8a7791: Add SATA nodes to r8a7791.dtsi
> >   ARM: dts: koelsch: Enable SATA0 in r8a7791-koelsch.dts
> >
> >  arch/arm/boot/dts/r8a7791-koelsch.dts |  4 ++++
> >  arch/arm/boot/dts/r8a7791.dtsi        | 18 ++++++++++++++++++
> >  2 files changed, 22 insertions(+)
>=20
> Hey Valentine,
>=20
> Thanks for your patches. I have now tested this series on my Koelsch
> board and it works well.
>=20
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks Magnus.

I will queue up these patches with the "dts:" in their subjects changed
to "shmobile:"
