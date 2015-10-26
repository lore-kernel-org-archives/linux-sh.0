From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 26 Oct 2015 02:08:04 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <5317790.cNUYDr4NzZ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Saturday 24 October 2015 19:46:11 Geert Uytterhoeven wrote:
> On Fri, Oct 23, 2015 at 2:49 PM, Laurent Pinchart wrote:
> >> --- a/include/misc/boot-mode-reg.h
> >> +++ b/include/misc/boot-mode-reg.h
> >> @@ -21,4 +21,7 @@
> >> 
> >>  int boot_mode_reg_get(u32 *mode);
> >>  int boot_mode_reg_set(u32 mode);
> >> 
> >> +/* Allow explicit initialisation before initcalls */
> >> +int rcar_gen2_init_boot_mode(void);
> >> +
> > 
> > I would move this to a separate header file.
> > 
> > And I'd like to also get rid of it :-) Do we need this function for any
> > purpose other than arch timer initialization in
> > arch/arm/mach-shmobile/setup-rcar-gen2.c ? Quickly looking it that code
> > I wonder whether we couldn't get the extal frequency from DT instead of
> > the boot mode pins, which would then remove the dependency.
> 
> We do have the extal frequency in DT.
> 
> The boot mode pins does not control the extal frequency, but a few dividers
> internal to the CPG.

Agreed, but in rcar_gen2_read_mode_pins() it's used to get the external clock 
frequency as each PLL setting is specific to one external frequency.

-- 
Regards,

Laurent Pinchart

