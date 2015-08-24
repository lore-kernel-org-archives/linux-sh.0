From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 Aug 2015 23:46:05 +0000
Subject: Re: [PATCH 06/25 v7][RFC] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <87vbc46yp2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k2sl77bs.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k2sl77bs.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


Hi Geert

> > From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >
> > Initial version of device tree for Renesas R-Car Gen3 SoC Kconfig
>=20
> Device tree?

This line was copied from

-----------------------------------
commit 5d1b79d2b2639bb71238e76d73431fada9e38553
Author: Michal Simek <michal.simek@xilinx.com>
Date:   Mon Mar 9 09:41:04 2015 +0100

    ARM64: Add new Xilinx ZynqMP SoC
   =20
    Initial version of device tree for Xilinx ZynqMP SoC.
   =20
    Signed-off-by: Michal Simek <michal.simek@xilinx.com>
    Acked-by: S=F6ren Brinkmann <soren.brinkmann@xilinx.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
-----------------------------------
commit 419043609689d0aba9f727a6faf1ff406e269ecf
Author: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Date:   Wed Nov 26 11:51:09 2014 +0700

    arm64: amd-seattle: Adding device tree for AMD Seattle platform
   =20
    Initial revision of device tree for AMD Seattle Development platform.
   =20
    Cc: Marc Zyngier <marc.zyngier@arm.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Will Deacon <will.deacon@arm.com>
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
    Signed-off-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
    Signed-off-by: Joel Schopp <Joel.Schopp@amd.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
-----------------------------------
