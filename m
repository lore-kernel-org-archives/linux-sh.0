From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 Oct 2015 16:19:27 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: r8a7794 ALT board DU VGA port enablement
Message-Id: <3469737.RKtA4Nnp8v@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151018051319.746.85959.sendpatchset@little-apple>
In-Reply-To: <20151018051319.746.85959.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patches.

On Sunday 18 October 2015 14:13:19 Magnus Damm wrote:
> ARM: shmobile: r8a7794 ALT board DU VGA port enablement
> 
> [PATCH 01/02] ARM: shmobile: r8a7794: Add DU device and MSTP clocks
> [PATCH 02/02] ARM: shmobile: r8a7794: alt: Enable VGA port
> 
> These patches enable VGA port support for the r8a7794 ALT board. No
> special merge time dependencies exist, however for correct run time
> operation "drm: rcar-du: Add support for the R8A7794 DU" is needed.
> 
> Tested with the modetest utility on the r8a7794 ALT board.
> # modetest -M rcar-du -c
> # modetest -M rcar-du -s 33:1024x768@AR24
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

I've posted a series named "[PATCH 0/5] R-Car DU: Add support for R8A7793 and 
R8A7794" back in July that includes two patches similar to your 01/02 patch. 
It was pending remote access to an Alt board for testing as the datasheet 
documents a single DU MSTP clock but Morimoto-san reported that the hardware 
includes two of them as in your patch.

I've sent a pull request today for the driver changes (1/5 and 2/5 from the 
series). Could you please take the rest of the patches and merge them with 
this series as appropriate when you'll post v2 ?

> ---
> 
>  Written against renesas-devel-20151015-v4.3-rc5
>  No special compile time dependencies.
>  Run time dependency on "drm: rcar-du: Add support for the R8A7794 DU"
> 
>  arch/arm/boot/dts/r8a7794-alt.dts         |   61 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7794.dtsi            |   36 +++++++++++++++--
>  include/dt-bindings/clock/r8a7794-clock.h |    2
>  3 files changed, 96 insertions(+), 3 deletions(-)

-- 
Regards,

Laurent Pinchart

