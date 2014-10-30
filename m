From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Oct 2014 00:10:07 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: Change to using clock-indices
Message-Id: <87zjcexvs4.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592353-24044-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414592353-24044-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org


Hi

> 	Hi Mike, Simon, Magnus,
> 
> This patch series finalizes the conversion from the vendor-specific
> "renesas,clock-indices" to the generic "clock-indices", started by Ben Dooks.
> 
> The patches for r8a7790 and r8a7791 were extracted from a patch that Ben sent
> before ("[PATCH 2/3] renesas: change to using clock-indices"), but it was never
> split/updated.
> 
> Thanks for applying!
> 
> Ben Dooks (2):
>   ARM: shmobile: r8a7790 dtsi: Change to using clock-indices
>   ARM: shmobile: r8a7791 dtsi: Change to using clock-indices
> 
> Geert Uytterhoeven (4):
>   clk: shmobile: Deprecate renesas,clock-indices
>   ARM: shmobile: r8a7740 dtsi: Change to using clock-indices
>   ARM: shmobile: r8a7779 dtsi: Change to using clock-indices
>   ARM: shmobile: r8a7794 dtsi: Change to using clock-indices
> 
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt         |  9 +++++----
>  arch/arm/boot/dts/r8a7740.dtsi                         | 10 +++++-----
>  arch/arm/boot/dts/r8a7779.dtsi                         |  6 +++---
>  arch/arm/boot/dts/r8a7790.dtsi                         | 16 ++++++++--------
>  arch/arm/boot/dts/r8a7791.dtsi                         | 18 +++++++++---------
>  arch/arm/boot/dts/r8a7794.dtsi                         | 14 +++++++-------
>  6 files changed, 37 insertions(+), 36 deletions(-)

I have been thought that we need this !

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Best regards
---
Kuninori Morimoto
