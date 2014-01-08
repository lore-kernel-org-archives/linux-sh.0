From: Simon Horman <horms@verge.net.au>
Date: Wed, 08 Jan 2014 07:27:09 +0000
Subject: Re: [PATCH 0/2] arm: shmobile: Add SATA support for Koelsch board
Message-Id: <20140108072706.GC18870@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Jan 08, 2014 at 04:18:12PM +0900, Magnus Damm wrote:
> On Fri, Dec 20, 2013 at 2:59 AM, Valentine Barshak
> <valentine.barshak@cogentembedded.com> wrote:
> > This adds SATA0/1 clocks to R8A7791 SoC and adds SATA0 to Koelsch board.
> > SATA1 is not available on Koelsch since MD24 selection is fixed to PCIe.
> >
> > It depends on the following commit available in the libata git tree:
> > https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3D=
for-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
> >
> > Valentine Barshak (2):
> >   arm: shmobile: r8a7791: Add SATA clocks
> >   arm: shmobile: koelsch: Add SATA support
> >
> >  arch/arm/mach-shmobile/board-koelsch.c | 17 +++++++++++++++++
> >  arch/arm/mach-shmobile/clock-r8a7791.c | 19 +++++++++++++++++++
> >  2 files changed, 36 insertions(+)
>=20
> Hi Valentine and Simon,
>=20
> I have now tested this Koelsch SATA series as well. It works well as
> long as the HDD is powered on at boot. When applying the patches I
> noticed that there were fewer collisions here due to no legacy clock
> status bit polling patch for r8a7791.
>=20
> Acked-by: Magnus Damm <damm@opensource.se>
>=20
> Simon, can you please work with Valentine to merge this series?

Sure.

Valentine, can you rebase and repost the series?

>=20
> Valentine, now when CCF support is included in recent devel tags, can
> you please consider cooking up DTS patches for SATA for the
> MULTIPLATFORM board support case for Lager and Koelsch?
>=20
> Thanks,
>=20
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
