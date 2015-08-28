From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Aug 2015 00:38:52 +0000
Subject: Re: [PATCH/RFC 02/10] arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC
Message-Id: <20150828003851.GB7357@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 12:52:13PM +0200, Geert Uytterhoeven wrote:
> On Thu, Aug 27, 2015 at 11:24 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >
> > Enable GPIO for  Renesas R-Car Gen3 SoC via the following options:
> >   - GPIO_SYSFS
> >   - GPIO_RCAR
> >   - LEDS_GPIO
> >
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > [horms: updated changelog]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm64/configs/defconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index a2ddca9c632b..e7b638eb5059 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -124,7 +124,9 @@ CONFIG_VIRTIO_CONSOLE=y
> >  CONFIG_SPI=y
> >  CONFIG_SPI_PL022=y
> >  CONFIG_PINCTRL_MSM8916=y
> > +CONFIG_GPIO_SYSFS=y
> 
> Do we really need GPIO_SYSFS?

Almost certainly not.

Looking over the patch again this morning
I think we also do not need LEDS_GPIO as the leds do not appear
to be enabled at this time.

I have revised the local version of this patch to only enable GPIO_RCAR.

My assumption is that Ulrich will take over this (albeit trivial) patch.

For reference this is what I tested just now:

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Subject: [PATCH/RFC v1.1] arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC

Enable GPIO_RCAR which is necessary and sufficient to enable
GPIO for the Renesas R-Car Gen3 r8a7775 SoC

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[horms: only enable GPIO_RCAR]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v0 [Takeshi Kihara]

v1 [Simon Horman]
* Reworded patch subject

v1.1 [Simon Horman]
* As suggested by Geert Uytterhoeven
  - Do not enable GPIO_SYSFS as it does not appear to be strictly related
* Dropped enabling LEDS_GPIO as this does not appear to be used at this time
* Updated changelog
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a2ddca9c632b..b7f7c5403884 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -125,6 +125,7 @@ CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_GPIO_PL061=y
+CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
-- 
2.1.4

