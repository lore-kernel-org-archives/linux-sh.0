From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Oct 2013 03:12:05 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: cleanup registration of VIN
Message-Id: <CANqRtoRHOTjir4BHP-2aH-eLaZrgGyjqeAhoVcPmzODm3VOgVQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ob6rdzg3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ob6rdzg3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Oct 15, 2013 at 11:45 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> VIN driver which needs platform data at the time of
> registration is used from Marzen only.
> Now, ARM/shmobile aims to support DT,
> and the C code base board support will be removed
> if DT support is completed.
> Current driver registration method which needs platform data
> and which is not shared complicates codes.
> This means legacy C code cleanup after DT supporting
> will be more complicated
> This patch registers it on board code as cleanup C code
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> This patch is based on renesas-devel-20131011 tag
>
>  arch/arm/mach-shmobile/board-marzen.c         |   24 ++++++++++++++--
>  arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 --
>  arch/arm/mach-shmobile/setup-r8a7779.c        |   37 -------------------------
>  3 files changed, 22 insertions(+), 41 deletions(-)

Thanks for cleaning up the code, Morimoto-san. Fewer lines and also
device registration in same style as other mach-shmobile SoCs and
boards, I like that.

Acked-by: Magnus Damm <damm@opensource.se>
