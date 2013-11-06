From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 06 Nov 2013 12:12:18 +0000
Subject: Re: [PATCH 03/10] ARM: shmobile: r8a7790: Reference clocks
Message-Id: <691872411.zhKdr1y4al@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383059082-26315-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383059082-26315-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 06 November 2013 16:18:06 Simon Horman wrote:
> On Tue, Oct 29, 2013 at 04:04:35PM +0100, Laurent Pinchart wrote:
> > Reference clocks using a "clocks" property in all nodes corresponding to
> > devices that require a clock.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  arch/arm/boot/dts/r8a7790-lager-reference.dts |  2 +-
> >  arch/arm/boot/dts/r8a7790-lager.dts           |  2 +-
> >  arch/arm/boot/dts/r8a7790.dtsi                | 12 ++++++++++++
> >  3 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts
> > b/arch/arm/boot/dts/r8a7790-lager-reference.dts index 75730f5..68711ce
> > 100644
> > --- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
> > @@ -9,7 +9,7 @@
> >   */
> >  
> >  /dts-v1/;
> > 
> > -/include/ "r8a7790.dtsi"
> > +#include "r8a7790.dtsi"
> >  #include <dt-bindings/gpio/gpio.h>
> >  
> >  / {
> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
> > b/arch/arm/boot/dts/r8a7790-lager.dts index 65ffd87..310fa63 100644
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -9,7 +9,7 @@
> >   */
> >  
> >  /dts-v1/;
> > 
> > -/include/ "r8a7790.dtsi"
> > +#include "r8a7790.dtsi"
> >  #include <dt-bindings/gpio/gpio.h>
> >  
> >  / {
> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi
> > b/arch/arm/boot/dts/r8a7790.dtsi index 423500d..94c8373 100644
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > @@ -8,6 +8,8 @@
> >   * kind, whether express or implied.
> >   */
> > 
> > +#include <dt-bindings/clock/r8a7790-clock.h>
> > +
> >  / {
> >  	compatible = "renesas,r8a7790";
> >  	interrupt-parent = <&gic>;
> 
> I believe that the hunks above need to be either present before or merged
> into the previous patch to avoid the following build errors.

You're right, I'll fix that. The initial implementation didn't make use of the 
symbols defined in dt-bindings/clock/r8a7790-clock.h in the previous patch and 
I forgot to compile-test all individual steps after changing this. I'll fix 
this.

> #make
> ...
>   DTC     arch/arm/boot/dts/r8a7790-lager.dtb
>   DTC     arch/arm/boot/dts/r8a7790-lager-reference.dtb
> Error: arch/arm/boot/dts/r8a7790.dtsi:349.30-31 syntax error
> Error: arch/arm/boot/dts/r8a7790.dtsi:349.30-31 syntax error
> FATAL ERROR: Unable to parse input tree
> FATAL ERROR: Unable to parse input tree
> 
> # dtc -v
> Version: DTC 1.3.0
-- 
Regards,

Laurent Pinchart

