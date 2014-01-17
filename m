From: Simon Horman <horms@verge.net.au>
Date: Fri, 17 Jan 2014 05:27:08 +0000
Subject: Re: [PATCH 0/2] ARM: dts: Add SATA to R8A7790 Lager device tree
Message-Id: <20140117052705.GC9302@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389719131-24376-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389719131-24376-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Jan 17, 2014 at 11:50:24AM +0900, Magnus Damm wrote:
> On Wed, Jan 15, 2014 at 2:05 AM, Valentine Barshak
> <valentine.barshak@cogentembedded.com> wrote:
> > This adds SATA nodes to r8a7790.dtsi and enables SATA1 in r8a7790-lager=
.dts.
> > In order for this to work the following patches are also needed:
> > * R-Car Gen2 SATA phy support:
> > https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3D=
for-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
> > * a couple of MSTP clock fixes:
> > http://marc.info/?l=3Dlinux-sh&m=138823255807611&w=3D2
> >
> > Valentine Barshak (2):
> >   ARM: dts: r8a7790: Add SATA nodes to r8a7790.dtsi
> >   ARM: dts: lager: Enable SATA1 in r8a7790-lager.dts
>=20
> Looking good, just boot tested this on my Lager board and it works as exp=
ected.
>=20
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued these up.
