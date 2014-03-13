From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 13 Mar 2014 11:50:03 +0000
Subject: Re: [PATCH] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <1694510.XDVPEHMvM1@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thursday 13 March 2014 12:27:43 Geert Uytterhoeven wrote:
> On Wed, Mar 12, 2014 at 10:04 PM, Laurent Pinchart wrote:
> > The MSTP[SC]R registers have clock stop bits, not clock enable bits. The
> > bit value should thus be inverted in the is_enabled() operation.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/clk/shmobile/clk-mstp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Geert, I believe this patch should fix the problem we've noticed with
> > clk_disable_unused() not disabling unused clocks. Could you please test it
> > ?
>
> Yes, now it disables the hardware clock bits for all clocks that are not in
> use according to CCF:
> 
> MSTP tmu0 OFF
> MSTP i2c0 OFF
> MSTP i2c1 OFF
> MSTP i2c2 OFF
> MSTP i2c3 OFF
> MSTP i2c4 OFF
> MSTP i2c5 OFF
> MSTP ether OFF
> MSTP msiof1 OFF
> MSTP msiof2 OFF
> MSTP msiof0 OFF
> MSTP qspi_mod OFF
> 
> and booting stops...

In a way, that's good, the results are consistent. I propose delaying this 
patch a bit though :-)

The tmu0 clock is supposed to be off, as we don't instantiate the device for 
r8a779[01].

The i2c driver acquires the device clock explicitly but doesn't enable/disable 
it.

The msiof and rspi drivers seem to enable/disable clocks explicitly, so they 
should probably work. However the rspi driver seems to be missing 
clk_prepare/clk_unprepare calls. Do you plan to fix that ?

The sh-eth driver doesn't perform any clock management.

The question is, how should we fix it in the short term ? Should we target 
runtime PM clock management straight away, or should we add manual clock 
handling to drivers as a first step ?

> So this exposes that all of the clocks above haven't really been enabled
> through CCF. The only reason they worked before is "sheer luck" (read:
> they were enabled before we booted Linux, due to reset state or boot
> loader).
> 
> The only clocks we do enable are those we register with
> shmobile_clk_workaround():
> 
> MSTP cmt0 ON
> MSTP scifa0 ON
> MSTP scifa1 ON
> MSTP scifb0 ON
> MSTP scifb1 ON
> MSTP scifb2 ON
> MSTP scifa2 ON
> MSTP scif0 ON
> MSTP scif1 ON
> MSTP scif2 ON
> MSTP scif3 ON
> MSTP scif4 ON
> MSTP scif5 ON
> MSTP scifa3 ON
> MSTP scifa4 ON
> MSTP scifa5 ON
> MSTP sata0 ON
> MSTP scif1 ON
> MSTP scif1 ON
> 
> To check yourself, add
> 
>     #include <linux/clk-private.h>
> 
> to drivers/clk/shmobile/clk-mstp.c, and add
> 
>     pr_info("MSTP %s %s\n", hw->clk->name, enable ? "ON" : "OFF")
> 
> to the top of cpg_mstp_clock_endisable().

-- 
Regards,

Laurent Pinchart

