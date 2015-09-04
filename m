From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Sep 2015 00:33:01 +0000
Subject: Re: [PATCH] [RFC] arm64: renesas: r8a7795: Complete SYS-DMAC nodes
Message-Id: <87io7rdo38.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441299107-9961-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441299107-9961-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> Complete the dma-controller nodes for SYS-DMAC 0 to 2, incl. their MSTP
> clocks.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   - Against today's topic/gen3-latest,
>   - To be folded into "arm64: renesas: r8a7795 dtsi: Add dummy
>     dma-controller nodes",
>   - The datasheet states the SYS-DMAC parent clock is the "ZS" clock,
>     which does not exist on R-Car Gen3 (on Gen2 that's the AXI clock).
>     Hence I used "S2D1" (AXI-bus) instead.

According to HW team, ZS -> S3D1

