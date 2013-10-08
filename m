From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Oct 2013 06:05:12 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: don't use named resource
Message-Id: <CANqRtoQE+aE00n9c9JWdvGqFVwQdKfGehF-OrDweGg4h5HJDsA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877gdoxq2d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gdoxq2d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 8, 2013 at 2:57 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> These patches cleanup named resource/irq which are not needed.
> Indeed some driver needs named resource/irq,
> but these are just excess.
>
> Kuninori Morimoto (7):
>       ARM: shmobile: ape6evm: don't use named resource for MMCIF
>       ARM: shmobile: ape6evm: don't use named resource for SDHI
>       ARM: shmobile: lager: don't use named resource for MMCIF
>       ARM: shmobile: sh73a0: don't use named resource for TMU
>       ARM: shmobile: sh73a0: don't use named resource for I2C
>       ARM: shmobile: sh73a0: don't use named resource for IPMMU
>       ARM: shmobile: r8a73a4: don't use named irq for DMAEngine
>
>  arch/arm/mach-shmobile/board-ape6evm.c |    6 +++---
>  arch/arm/mach-shmobile/board-lager.c   |    2 +-
>  arch/arm/mach-shmobile/setup-r8a73a4.c |    2 +-
>  arch/arm/mach-shmobile/setup-sh73a0.c  |   16 ++++++++--------
>  4 files changed, 13 insertions(+), 13 deletions(-)

Hi Morimoto-san,

These look good to me, thanks for your help!

Acked-by: Magnus Damm <damm@opensource.se>

/ magnus
