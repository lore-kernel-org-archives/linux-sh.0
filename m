From: Simon Horman <horms@verge.net.au>
Date: Mon, 13 May 2013 00:40:01 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: lager: enable Ether
Message-Id: <20130513004001.GC22911@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-1-git-send-email-horms+renesas@verge.net.au>
 <1368173119-27345-3-git-send-email-horms+renesas@verge.net.au>
 <518CCD55.6070101@cogentembedded.com>
In-Reply-To: <518CCD55.6070101@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

[ CC Laurent ]

On Fri, May 10, 2013 at 02:35:01PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 10-05-2013 12:05, Simon Horman wrote:
> 
> >Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> >---
> 
> >This patch has a run-time dependency on "sh_eth: add support for r8a7790 SoC".
> >---
> >  arch/arm/boot/dts/r8a7790-lager.dts  |  2 +-
> >  arch/arm/mach-shmobile/board-lager.c | 26 ++++++++++++++++++++++++++
> >  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> >diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> >index 09a84fc..b2f61f0 100644
> >--- a/arch/arm/boot/dts/r8a7790-lager.dts
> >+++ b/arch/arm/boot/dts/r8a7790-lager.dts
> >@@ -16,7 +16,7 @@
> >  	compatible = "renesas,lager", "renesas,r8a7790";
> >
> >  	chosen {
> >-		bootargs = "console=ttySC6,115200 ignore_loglevel";
> >+		bootargs = "console=ttySC6,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96 rw";
> >  	};
> >
> >  	memory@40000000 {
> 
>    Perhaps you shouldn't mix .dts changes with source changes?

Sure, I can break that out into a separate patch.

> 
> >diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> >index 6a1ba38..0b8112d 100644
> >--- a/arch/arm/mach-shmobile/board-lager.c
> >+++ b/arch/arm/mach-shmobile/board-lager.c
> [...]
> >@@ -59,6 +69,17 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
> >  	/* SCIF1 (CN20: DEBUG SERIAL1) */
> >  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
> >  				  "scif1_data", "scif1"),
> >+	/* Ether */
> >+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> >+				  "eth_link", "eth"),
> >+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> >+				  "eth_magic", "eth"),
> >+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> >+				  "eth_mdio", "eth"),
> >+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> >+				  "eth_rmii", "eth"),
> 
>     I thought MDIO bus was a part of RMII. At least Wikipedia told
> me so. :-)

Is the implication that you think that the eth_mdio and eth_rmii
groups should be combined?
