From: Simon Horman <horms@verge.net.au>
Date: Thu, 01 Aug 2013 07:58:39 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: bockw: add SDHI0 support
Message-Id: <20130801075839.GA32593@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878v4henwe.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878v4henwe.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 31, 2013 at 04:09:13PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 31-07-2013 4:22, Simon Horman wrote:
> 
> >>>This patch is directly accessing to PUPR4 register which can
> >>>control SDHI0 CD/WP pin pull-up setting.
> >>>It should be replaced in the future.
> 
> >>>Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>>---
> >>>  arch/arm/mach-shmobile/board-bockw.c |   29 +++++++++++++++++++++++++++++
> >>>  1 file changed, 29 insertions(+)
> 
> >>>diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> >>>index 4d65715..2b6103e 100644
> >>>--- a/arch/arm/mach-shmobile/board-bockw.c
> >>>+++ b/arch/arm/mach-shmobile/board-bockw.c
> >>[...]
> >>>  static const struct pinctrl_map bockw_pinctrl_map[] = {
> >>>  	/* SCIF0 */
> >>>  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
> >>>  				  "scif0_data_a", "scif0"),
> >>>  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
> >>>  				  "scif0_ctrl", "scif0"),
> >>>+	/* SDHI0 */
> >>>+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
> >>>+				  "sdhi0", "sdhi0"),
> >>>  };
> 
> >>    These SDHI0 data above don't match
> >>drivers/pinctrl/sh-pfc/pfc-r8a7778.c and cause this message:
> 
> >>sh-pfc pfc-r8a7778: invalid group "sdhi0" for function "sdhi0"
> 
> >>    I'm not sure but maybe because of this SD card can't be detected.
> 
> >Hi,
> 
> >is there a resolution for this problem?
> >I believe that this patch was included in v3.11-rc1.
> 
>    I posted the patch about an hour after this message:
> 
> http://marc.info/?l=linux-sh&m7488241212082

Thanks for the clarification.

That patch is currently sitting in the
fixes-for-v3.11 branch which I tagged as renesas-fixes2-for-v3.11
and send a pull request for recently.
