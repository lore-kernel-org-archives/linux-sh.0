From: Simon Horman <horms@verge.net.au>
Date: Fri, 29 Mar 2013 03:48:40 +0000
Subject: Re: [PATCH 2/2] ARM: remove mach .init_irq for irqchip_init users
Message-Id: <20130329034839.GB13429@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364463704-13692-1-git-send-email-maxime.ripard@free-electrons.com>
 <1364463704-13692-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130328124228.GA29616@verge.net.au>
 <51548AC2.1010802@free-electrons.com>
In-Reply-To: <51548AC2.1010802@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 28, 2013 at 07:24:02PM +0100, Maxime Ripard wrote:
> Hi Simon,
>=20
> Le 28/03/2013 13:42, Simon Horman a =C3=A9crit :
> > On Thu, Mar 28, 2013 at 10:41:44AM +0100, Maxime Ripard wrote:
> >> Now that the arm core code calls irqchip_init, we can remove it from a=
ll
> >> the machines that were using it.
> >>
> >> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >> ---
> >>  arch/arm/mach-bcm/board_bcm.c                  |    1 -
> >>  arch/arm/mach-msm/board-dt-8660.c              |    1 -
> >>  arch/arm/mach-msm/board-dt-8960.c              |    1 -
> >>  arch/arm/mach-nomadik/cpu-8815.c               |    1 -
> >>  arch/arm/mach-picoxcell/common.c               |    1 -
> >>  arch/arm/mach-prima2/common.c                  |    1 -
> >>  arch/arm/mach-shmobile/board-kzm9g-reference.c |    1 -
> >>  arch/arm/mach-shmobile/setup-emev2.c           |    1 -
> >>  arch/arm/mach-shmobile/setup-sh73a0.c          |    1 -
> >>  arch/arm/mach-spear/spear1310.c                |    1 -
> >>  arch/arm/mach-spear/spear1340.c                |    1 -
> >>  arch/arm/mach-spear/spear300.c                 |    1 -
> >>  arch/arm/mach-spear/spear310.c                 |    1 -
> >>  arch/arm/mach-spear/spear320.c                 |    1 -
> >>  arch/arm/mach-spear/spear6xx.c                 |    1 -
> >>  arch/arm/mach-vexpress/v2m.c                   |    1 -
> >>  arch/arm/mach-virt/virt.c                      |    1 -
> >>  arch/arm/mach-zynq/common.c                    |    1 -
> >>  18 files changed, 18 deletions(-)
> >=20
> > mach-shmobile portion:
> >=20
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> Thanks!
>=20
> >=20
> > I have some new users of this queued up for v3.10.
> > How should we handle that?
>=20
> Since the old behaviour is preserved, I guess it doesn't matter much,
> and one of us can always make a followup patch on top of these patches.

Ok, sound good.
