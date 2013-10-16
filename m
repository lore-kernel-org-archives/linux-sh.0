From: Simon Horman <horms@verge.net.au>
Date: Wed, 16 Oct 2013 00:47:47 +0000
Subject: Re: [PATCH 01/17] ARM: shmobile: r8a73a4: fixup DT node naming for SDHI
Message-Id: <20131016004747.GQ22321@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87hacjdlmi.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hacjdlmi.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 15, 2013 at 05:26:12PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 15-10-2013 11:44, Kuninori Morimoto wrote:
> 
> >According to ePAPR spec,
> >this patch exchanges SDHI DT node from "sdhi" to "sd".
> 
> >Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >---
> >  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   16 ++++++++--------
> >  arch/arm/boot/dts/r8a73a4.dtsi                  |    6 +++---
> >  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> >diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> >index 287e047..447c128 100644
> >--- a/arch/arm/boot/dts/r8a73a4.dtsi
> >+++ b/arch/arm/boot/dts/r8a73a4.dtsi
> >@@ -244,7 +244,7 @@
> >  		#gpio-cells = <2>;
> >  	};
> >
> >-	sdhi0: sdhi@ee100000 {
> >+	sd0: sd@ee100000 {
> 
>    Having to change the node names doesn't mean you need to change
> the labels too (and PFC-related node names too). In fact, I think
> the existing labels are better.

My, this is tedious.

Looking at other dts files I see a lot of entries
of the form "mmcX: mmc@...". And I think that Morimoto-san's patches
are in keeping with that style.

On the other hand, I see your point that its much clearer
to use sdhi0 as that is what the hw manuals refer to and
it would allow differentiation with mmcif.

So I lean towards Sergei's suggestion being a bit nicer.

Morimoto-san, what is your feeling on this?
