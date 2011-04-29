From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 29 Apr 2011 20:16:26 +0000
Subject: Re: [PATCH/RFC] ARM: mach-shmobile: sh7372 power domain prototype
Message-Id: <201104292216.26387.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20110411194911.7991.79950.sendpatchset@t400s>
In-Reply-To: <20110411194911.7991.79950.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday, April 29, 2011, Guennadi Liakhovetski wrote:
> On Thu, 21 Apr 2011, Guennadi Liakhovetski wrote:
> 
> > On Tue, 19 Apr 2011, Guennadi Liakhovetski wrote:
> > 
> > > On Fri, 15 Apr 2011, Guennadi Liakhovetski wrote:
> > > 
> > > > Hi Magnus
> > > > 
> > > > On Tue, 12 Apr 2011, Magnus Damm wrote:
> > > > 
> > > > > From: Magnus Damm <damm@opensource.se>
> > > > > 
> > > > > This experimental sh7372-specific Runtime PM prototype
> > > > > adds support for the A4LC and A4MP power domains.
> > > > > 
> > > > > Tested on the Mackerel board together with the LCDC:
> > > > > 
> > > > > # blank HDMI fbdev
> > > > > echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.1/graphics/fb1/blank
> > > > > 
> > > > > # blank LCD panel fbdev
> > > > > echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
> > > > > # unblank LCD panel fbdev
> > > > > echo 0 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
> > > > > 
> > > > > Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
> > > > > ---
> > > > > 
> > > > >  arch/arm/mach-shmobile/pm_runtime.c |  227 ++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 222 insertions(+), 5 deletions(-)
> > > > 
> > > > Your patch worked mostly, below is a small addition (to be applied on top 
> > > > of your patch), that adds several new domains and devices and fixes a 
> > > > couple of issues with your original patch. Notice an "#if 0" around i2c 
> > > > devices: activating them causes problems - output on the LCDC disappears 
> > > > and the boot process doesn't complete, but without a serial console I 
> > > > couldn't tell, what exactly was the problem. Should be investigated 
> > > > further.
> > > 
> > > Below is a fixed version of the earlier proposed fix;)
> > 
> > v3: I think, I've got the use-counting and power-domain initialisation 
> > correct this time too. At least this version works without any need to 
> > modify the runtime PM core.
> 
> v4: (1) add checks for BIT_ACTIVE for devices without any clocks 
> associated with them, this fixes Oopses. (2) I think, this time I've 
> finally found _the_ correct time and place to remove the "prd" from the 
> list. As before, this is a work in progress, subject to change, depending 
> on surrounding developments. Posting here just for reference.

Please have a look at these patches:
https://patchwork.kernel.org/patch/740162/
https://patchwork.kernel.org/patch/740152/
which are based on the patchset from:
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git power-domains

Do you think it would be possible to rebase your work on top of them?
If not, please tell me what the problems are.

Thanks,
Rafael
