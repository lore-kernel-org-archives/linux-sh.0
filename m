From: Olof Johansson <olof@lixom.net>
Date: Tue, 08 Jul 2014 05:07:08 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Updates for v3.17
Message-Id: <20140708050708.GC28931@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 25, 2014 at 04:35:24PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>=20
> Please consider these Renesas ARM based SoC updates for v3.17.
>=20
> This pull request is based on 'Renesas ARM Based SoC Header Cleanup for v=
3.17',
> tagged as header-cleanup-for-v3.17, which I have already sent a
> pull-request for.=20
>=20
> The following changes since commit 62872989bdbf1245d7239b9f4c05a8ee7c775e=
d5:
>=20
>   ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case (2014-06-17 17:09=
:40 +0900)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas=
-soc-for-v3.17
>=20
> for you to fetch changes up to 3ed66ec5ced8b801cb851b2b8548301df94f8f54:
>=20
>   ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile (2014-06-23 =
09:53:55 +0900)
>=20
> ----------------------------------------------------------------
> Renesas ARM Based SoC Updates for v3.17
>=20
> * Use shmobile_init_late on r8a7791 and r8a7790 whien booting using DT-on=
ly
> * Support Core-Standby for Suspend to RAM on r8a7791 and r8a7790 SoCs
> * Shared CMA reservation for R-Car Gen2 SoCs
> * Add r8a7791 SYSC power management support

This branch also seems to contain a bunch of bugfixes? Did they get merged =
into
the wrong base, or what's going on?

> Benoit Cousson (1):
>       ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable
>=20
> Gaku Inami (1):
>       ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile

The latter patch fixes the former, why not just fold them in?

> Geert Uytterhoeven (3):
>       ARM: shmobile: rcar-gen2: Update for of_get_flat_dt_prop() update
>       ARM: shmobile: rcar-gen2: Use "1ULL" instead of "(u64)1"
>       ARM: shmobile: rcar-gen2: Remove useless copied section for LongTra=
il

The last two seem to be small bug fixes/cleanups. They should probably go i=
n a
cleanup branch unless there are conflicts with new development. Even then, =
we
tend to prefer to order it with the cleanups/fixes before new development
(where it doesn't cause extra complications).

>=20
> Magnus Damm (3):
>       ARM: shmobile: Use shmobile_init_late() on r8a7790 DT-only
>       ARM: shmobile: Use shmobile_init_late() on r8a7791 DT-only
>       ARM: shmobile: Add shared R-Car Gen2 CMA reservation code
>=20
> Simon Horman (1):
>       ARM: shmobile: rcar-gen2: correct return value of shmobile_smp_apmu=
_suspend_init
>=20
> Vincent Stehl=E9 (1):
>       ARM: shmobile: rcar-gen2: update call to dma_contiguous_reserve_area

Again those two patches seem to be fixes, the former to a patch in this very
branch.

> keita kobayashi (4):
>       ARM: shmobile: r8a7791 SYSC setup code
>       ARM: shmobile: APMU: Add Core-Standby-state for Suspend to RAM
>       ARM: shmobile: r8a7790: Support Core-Standby for Suspend to RAM
>       ARM: shmobile: r8a7791: Support Core-Standby for Suspend to RAM

Anyway, I've merged it in as it is. Keep some of the above stuff in mind
for future releases though.


-Olof
