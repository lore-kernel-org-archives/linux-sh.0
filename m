From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 05 Jul 2013 05:03:33 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: APE6EVM: add a reference DT implementation
Message-Id: <CANqRtoTQ1PTnO0+uN3HR=HDMY1YVTdb_Ddk+Y2OdKK8SSivvLQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372970438-21549-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372970438-21549-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 5, 2013 at 5:40 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch series adds a DT-based APE6EVM platform implementation. The
> first of them prepares auxiliary device handling functions for the r8a73a4
> SoC, and the second one adds a the actual platform support.
>
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>
> Guennadi Liakhovetski (2):
>   ARM: shmobile: r8a73a4: reorganise device instantiation in DT case
>   ARM: shmobile: APE6EVM: add DT reference

As I already mentioned for several days, please model your code after
the Lager DT reference board code from Simon.

Since details seem to be necessary, more exactly the version below
(the latest, surprise!) should be followed:

[PATCH v3] ARM: shmobile: lager: Add DT reference

As you can see, Simon is sending a single patch to implement this, I
recommend you to do the same.

>  arch/arm/boot/dts/Makefile                       |    1 +
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   76 +++++++++++++++++++++
>  arch/arm/mach-shmobile/Kconfig                   |   11 +++
>  arch/arm/mach-shmobile/Makefile                  |    1 +
>  arch/arm/mach-shmobile/board-ape6evm-reference.c |   77 ++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/r8a73a4.h    |    1 +
>  arch/arm/mach-shmobile/setup-r8a73a4.c           |   17 ++++-
>  7 files changed, 181 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
>  create mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c

There seem to be information missing about which commit you wrote this
code against. So the merge order of these series is unknown:

[PATCH 0/2] ARM: shmobile: APE6EVM: add a reference DT implementation
[PATCH 0/6] ARM: shmobile: DMAC, MMCIF and SDHI for H2 and APE6

Please include such information in the future.

Thanks,

/ magnus
