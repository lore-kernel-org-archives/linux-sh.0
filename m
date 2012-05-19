From: Olof Johansson <olof@lixom.net>
Date: Sat, 19 May 2012 19:05:40 +0000
Subject: Re: [GIT PULL] Renesas Emma Mobile EV2 SoC and KZM9D board support for v3.5
Message-Id: <CAOesGMgZ_rDFCQf33JYZmTLgzzyGm2w9Cfc1dmw1E7T74mwaxA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201205182344.59703.rjw@sisk.pl> <201205182355.47754.rjw@sisk.pl>
In-Reply-To: <201205182355.47754.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

On Fri, May 18, 2012 at 2:55 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
>
> =A0 =A0Linux 3.4-rc6
>
> with top-most commit 450cca47d65b7500ba05d56770adbf8c758dc87d
>
> =A0 =A0mach-shmobile: Use DT_MACHINE for KZM9D V3
>
> from the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git emev2
>
> to receive commits adding support for the Emma Mobile EV2 SoC and the KZM=
9D
> board targeted at v3.5.
>
> This is based on material that I have just sent another pull request for.
>
> Thanks!
>
>
> =A0arch/arm/boot/dts/emev2-kzm9d.dts =A0 =A0 =A0 =A0 =A0 | =A0 26 ++
> =A0arch/arm/boot/dts/emev2.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 63 +=
+++
> =A0arch/arm/mach-shmobile/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
> =A0arch/arm/mach-shmobile/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/arm/mach-shmobile/board-kzm9d.c =A0 =A0 =A0 =A0| =A0 85 +++++
> =A0arch/arm/mach-shmobile/clock-emev2.c =A0 =A0 =A0 =A0| =A0249 +++++++++=
++++++
> =A0arch/arm/mach-shmobile/include/mach/emev2.h | =A0 19 ++
> =A0arch/arm/mach-shmobile/platsmp.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 18 +
> =A0arch/arm/mach-shmobile/setup-emev2.c =A0 =A0 =A0 =A0| =A0452 +++++++++=
++++++++++++++++++
> =A0arch/arm/mach-shmobile/smp-emev2.c =A0 =A0 =A0 =A0 =A0| =A0 97 ++++++
> =A0drivers/gpio/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A06 +
> =A0drivers/gpio/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A01 +
> =A0drivers/gpio/gpio-em.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0418 +++++++++++++++++++++++++
> =A0include/linux/platform_data/gpio-em.h =A0 =A0 =A0 | =A0 10 +
> =A014 files changed, 1458 insertions(+), 0 deletions(-)

This is a bit odd. The pull request says "since v3.4-rc6", but the
branch is built on top of renesas/soc-core, so if I do a "git diff
--stat v3.4-rc6 FETCH_HEAD" I see the whole diffstat which doesn't
match. Did you mix and match the diffstat and the rest of the pull
request output, per chance?

> ---------------
>
> Magnus Damm (8):
> =A0 =A0 =A0gpio: Emma Mobile GPIO driver V2
> =A0 =A0 =A0mach-shmobile: Emma Mobile EV2 SoC base support V3
> =A0 =A0 =A0mach-shmobile: KZM9D board support V3
> =A0 =A0 =A0mach-shmobile: Emma Mobile EV2 SMP support V3
> =A0 =A0 =A0mach-shmobile: Emma Mobile EV2 GPIO support V3
> =A0 =A0 =A0mach-shmobile: KZM9D board Ethernet support V3
> =A0 =A0 =A0mach-shmobile: Emma Mobile EV2 DT support V3
> =A0 =A0 =A0mach-shmobile: Use DT_MACHINE for KZM9D V3

I was mislead for a while when looking at the contents here since you
introduce the board file without DT_MACHINE and switch in a later
commit. It would have been a bit cleaner to squash it in and add it
that way directly, especially since it's otherwise not buildable.
Anyway, not a huge deal.

Also, please remember to use ARM: shmobile: as prefix in the future.

All that being said, I've pulled this in as renesas/emev2 and into
next/soc. There's an add/add conflict between this and the kzm9g board
addition but it's trivial to resolve; please double-check the for-next
contents in arm-soc though.

In the future, given the organization of arm-soc, it would be better
to do the SoC portion in one branch, and the board pieces on top of
that (in a separate branch that includes the SoC pieces), and send
them up separately. Main reason for that is because we try to separate
those two as topics. Again, not a huge deal but it would help a bit,
and I don't think it'll hinder your work flow too much.


-Olof
