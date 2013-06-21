From: Simon Horman <horms@verge.net.au>
Date: Fri, 21 Jun 2013 06:15:28 +0000
Subject: Re: [PATCH v4 0/5] Renesas TPU PWM support
Message-Id: <20130621061528.GA30041@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 20, 2013 at 01:15:11PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 17 June 2013 12:31:39 Laurent Pinchart wrote:
> > On Monday 17 June 2013 13:25:49 Simon Horman wrote:
> > > Hi Laurent,
> > > 
> > > I am having a little trouble testing this.
> > > I am wondering if you could guide me as to
> > > what .config options I should have enabled and
> > > what values I should be looking for in /sys ?
> > 
> > Sure. You need to enable CONFIG_LEDS_PWM and CONFIG_PWM_RENESAS_TPU). You
> > should then be able to control the LEDs through /sys/class/leds/*.
> 
> Any luck ?

Hi Laurent,

I have confirmed that I can toggle the G H and J LEDs.
Should I queue-up this patchset?


On the way I noticed the following:

sh-pfc pfc-sh73a0: pin PORT163 already requested by renesas-tpu-pwm.3; cannot claim for sh-sci.8
sh-pfc pfc-sh73a0: pin-163 (sh-sci.8) status -22

sh-pfc pfc-sh73a0: pin 1195 is not registered so it cannot be requested
sh-pfc pfc-sh73a0: pin-1195 (sh_keysc.0) status -22
sh-pfc pfc-sh73a0: could not request pin 1195 on device sh-pfc
sh_keysc sh_keysc.0: Error applying setting, reverse things back


My personal feeling is that if these are trivial to fix
then it would be worth doing so. Otherwise a discussion
needs to be had about support for the kota2.
