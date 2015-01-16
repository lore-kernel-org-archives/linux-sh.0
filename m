From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 16 Jan 2015 07:38:22 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: r8a779x: add SDHI DMA support
Message-Id: <CAPDyKFrFoep6CnTrSq77t2JgqqmnwF1JV2mRbyON8ohurfu_oQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq4ny1ig.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wq4ny1ig.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 16 January 2015 at 02:09, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Simon
> Cc Ulf
>
> These are SDHI DMA support for r8a7790/r8a7791.
> These are based on Ulf's
> git://git.linaro.org/people/ulf.hansson/mmc.git :: next
>
> or, especially this commit
> 5f04044fbb32cedef8cf0ea777a632882f065698
> (mmc: sh_mobile_sdhi: tidyup mmc_data->bus_shift for latest SoC)
>
> Ulf, please let us know if we need to based on other branch

Please don't use my next branch, since I rebase it frequently.

I will share an immutable branch from mmc tree, called "tmio", It will
contain only your tmio fixes. I will do this early next week since I
want to base it on 3.19 rc5.

Kind
Uffe

>
> Kuninori Morimoto (4):
>       ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
>       ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI
>       ARM: shmobile: r8a7790: add SDHI DMA channels on DTSI
>       ARM: shmobile: r8a7791: add SDHI DMA channels on DTSI
>
>  arch/arm/boot/dts/r8a7790.dtsi |   12 ++++++++++--
>  arch/arm/boot/dts/r8a7791.dtsi |    8 +++++++-
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
>
> Best regards
> ---
> Kuninori Morimoto
