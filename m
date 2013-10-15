From: Simon Horman <horms@verge.net.au>
Date: Tue, 15 Oct 2013 00:35:22 +0000
Subject: Re: [PATCH 06/10] ARM: shmobile: r8a7778: add SDHI support on DTSI
Message-Id: <20131015003522.GJ22321@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2nc1fi8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2nc1fi8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 11, 2013 at 11:26:33PM +0200, Sergei Shtylyov wrote:
> Hello.
> 
> On 11-10-2013 8:35, Kuninori Morimoto wrote:
> 
> >Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >---
> >  arch/arm/boot/dts/r8a7778.dtsi |   30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> 
> >diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> >index 0ff38e6..873eeb9 100644
> >--- a/arch/arm/boot/dts/r8a7778.dtsi
> >+++ b/arch/arm/boot/dts/r8a7778.dtsi
> >@@ -164,4 +164,34 @@
> >  		interrupts = <0 61 4>;
> >  		status = "disabled";
> >  	};
> >+
> >+	sdhi0: sdhi@ffe4c000 {
> 
>    ePAPR spec [1] says:
> 
> "The name of a node should be somewhat generic, reflecting the
> function of the device and not its precise programming model." So I
> suggest using "mmc" or "sd" instead.
> 
> [1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

Morimoto-san,

would it be possible for you to either update this patch or provide a
subsequent incremental to use "mmc" or "sd" as Sergei suggests. I have a
slight preference for "mmc" but please use your own judgement.

If you could also provide patches to update existing dts/dtsi files
that would be awesome.
