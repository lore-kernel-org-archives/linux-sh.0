From: Simon Horman <horms@verge.net.au>
Date: Thu, 09 Jan 2014 09:02:27 +0000
Subject: Re: [PATCH 0/2] arm: shmobile: Add SATA support for Koelsch board
Message-Id: <20140109090224.GA20661@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Jan 08, 2014 at 04:27:09PM +0900, Simon Horman wrote:
> On Wed, Jan 08, 2014 at 04:18:12PM +0900, Magnus Damm wrote:
> > On Fri, Dec 20, 2013 at 2:59 AM, Valentine Barshak
> > <valentine.barshak@cogentembedded.com> wrote:
> > > This adds SATA0/1 clocks to R8A7791 SoC and adds SATA0 to Koelsch boa=
rd.
> > > SATA1 is not available on Koelsch since MD24 selection is fixed to PC=
Ie.
> > >
> > > It depends on the following commit available in the libata git tree:
> > > https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=
=3Dfor-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
> > >
> > > Valentine Barshak (2):
> > >   arm: shmobile: r8a7791: Add SATA clocks
> > >   arm: shmobile: koelsch: Add SATA support
> > >
> > >  arch/arm/mach-shmobile/board-koelsch.c | 17 +++++++++++++++++
> > >  arch/arm/mach-shmobile/clock-r8a7791.c | 19 +++++++++++++++++++
> > >  2 files changed, 36 insertions(+)
> >=20
> > Hi Valentine and Simon,
> >=20
> > I have now tested this Koelsch SATA series as well. It works well as
> > long as the HDD is powered on at boot. When applying the patches I
> > noticed that there were fewer collisions here due to no legacy clock
> > status bit polling patch for r8a7791.
> >=20
> > Acked-by: Magnus Damm <damm@opensource.se>
> >=20
> > Simon, can you please work with Valentine to merge this series?
>=20
> Sure.
>=20
> Valentine, can you rebase and repost the series?

And include an update to the Koelsch defconfig
