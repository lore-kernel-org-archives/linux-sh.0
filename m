From: Simon Horman <horms@verge.net.au>
Date: Wed, 08 Jan 2014 07:26:08 +0000
Subject: Re: [PATCH 0/2] arm: shmobile: Add SATA support for Lager board
Message-Id: <20140108072605.GB18870@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Jan 08, 2014 at 03:40:23PM +0900, Magnus Damm wrote:
> On Fri, Dec 20, 2013 at 2:57 AM, Valentine Barshak
> <valentine.barshak@cogentembedded.com> wrote:
> > This adds SATA0/1 clocks to R8A7790 SoC and adds SATA1 to Lager board.
> > SATA0 is not available on Lager since MD23 selection is fixed to USB3.
> >
> > It depends on the following commit available in the libata git tree:
> > https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3D=
for-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
> >
> > Valentine Barshak (2):
> >   arm: shmobile: r8a7790: Add SATA clock
> >   arm: shmobile: lager: Add SATA support
> >
> >  arch/arm/mach-shmobile/board-lager.c   | 17 +++++++++++++++++
> >  arch/arm/mach-shmobile/clock-r8a7790.c | 19 +++++++++++++++++++
> >  2 files changed, 36 insertions(+)
>=20
> Hi Valentine and Simon,
>=20
> Thanks for your patches. I have now successfully tested this Lager
> SATA (pdev) series on my hardware. My SATA HDD can be used on Lager as
> long as the drive is powered on before kernel boot.
>=20
> Due to delay on my side (my apologies, moved house) there seems to
> have been some bitrot, so I had to manually fix up the patches to make
> them fit on "renesas-devel-v3.13-rc7-20140108". It seems to me that
> you may need to use SH_CLK_MSTP32_STS() now, so I suspect that you
> need to update the patch series to match latest devel tag. Feel free
> to include this:
>=20
> Acked-by: Magnus Damm <damm@opensource.se>
>=20
> Also, the Lager defconfig probably wants to be updated to include SATA su=
pport.
>=20
> Simon, can you please work with Valentine to merge this series?

Sure, will do.
