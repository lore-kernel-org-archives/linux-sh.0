From: Simon Horman <horms@verge.net.au>
Date: Tue, 28 Apr 2015 00:57:29 +0000
Subject: Re: [PATCH 00/10] ARM: shmobile: Use generic names for device nodes
Message-Id: <20150428005728.GC557@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 27, 2015 at 02:55:24PM +0200, Geert Uytterhoeven wrote:
> 	Hi Magnus, Simon,
> 
> This patch series gets rid of the last non-generic device nodes names in
> the shmobile DTS files, and replaces them by generic names, cfr. ePAPR.
> 
> Thanks for applying!

Thanks!

I have queued up the patches except for 08/10 which Sergei raised
a concern about for which I am unsure of the resolution of.

> 
> Geert Uytterhoeven (10):
>   ARM: shmobile: r8a7740 dtsi: Use generic names for device nodes
>   ARM: shmobile: r8a7778 dtsi: Use generic names for device nodes
>   ARM: shmobile: r8a7779 dtsi: Use generic names for device nodes
>   ARM: shmobile: r8a7790 dtsi: Use generic names for device nodes
>   ARM: shmobile: r8a7791 dtsi: Use generic names for device nodes
>   ARM: shmobile: sh73a0 dtsi: Use generic names for device nodes
>   ARM: shmobile: ape6evm dts: Use generic names for device nodes
>   ARM: shmobile: armadillo800eva dts: Use generic names for device nodes

The above armadillo800eva patch is 08/10; the one I have not queued up (yet).

>   ARM: shmobile: kzm9d dts: Use generic names for device nodes
>   ARM: shmobile: marzen dts: Use generic names for device nodes
> 
>  arch/arm/boot/dts/emev2-kzm9d.dts             | 4 ++--
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts         | 2 +-
>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
>  arch/arm/boot/dts/r8a7740.dtsi                | 8 ++++----
>  arch/arm/boot/dts/r8a7778.dtsi                | 2 +-
>  arch/arm/boot/dts/r8a7779-marzen.dts          | 6 +++---
>  arch/arm/boot/dts/r8a7779.dtsi                | 2 +-
>  arch/arm/boot/dts/r8a7790.dtsi                | 2 +-
>  arch/arm/boot/dts/r8a7791.dtsi                | 2 +-
>  arch/arm/boot/dts/sh73a0.dtsi                 | 8 ++++----
>  10 files changed, 19 insertions(+), 19 deletions(-)
