From: Olof Johansson <olof@lixom.net>
Date: Tue, 28 May 2013 04:02:43 +0000
Subject: Re: [PATCH 1/8] ARM: shmobile: sh73a0 pinmux platform device cleanup
Message-Id: <20130528040243.GM13532@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1369645252-3847-1-git-send-email-horms+renesas@verge.net.au>
 <1369645252-3847-2-git-send-email-horms+renesas@verge.net.au>
 <51A36A02.9050200@cogentembedded.com>
In-Reply-To: <51A36A02.9050200@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, May 27, 2013 at 06:13:22PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 27-05-2013 13:00, Simon Horman wrote:
> 
> >From: Magnus Damm <damm@opensource.se>
> 
> >Use DEFINE_RES_MEM() and platform_device_register_simple()
> >to save a couple of lines of code.
> 
> >Signed-off-by: Magnus Damm <damm@opensource.se>
> >Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/mach-shmobile/setup-sh73a0.c |   25 ++++++-------------------
> >  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> >diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> >index fdf3894..f8f4261 100644
> >--- a/arch/arm/mach-shmobile/setup-sh73a0.c
> >+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> >@@ -61,29 +61,16 @@ void __init sh73a0_map_io(void)
> [...]
> >+/* PFC */
> >+static const struct resource pfc_resources[] = {
> 
>    Should have been annotated as __initdata... too late, need
> another patch.

See comments on other patches/pull requests, I think there's time to revisit
this. I.e. I'll hold off on pulling this based on the other feedback.


-Olof
