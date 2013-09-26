From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Sep 2013 08:24:03 +0000
Subject: Re: [PATCH/RFC v4] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <Pine.LNX.4.64.1309261018440.11968@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

On Thu, 26 Sep 2013, Linus Walleij wrote:

> On Wed, Sep 25, 2013 at 11:05 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> 
> >> > 3. RFC because I don't know how to enable choosing between CON14 and CON8.
> >> > In .c version this is done by reading GPIO 6. To do the same in DT mode
> >> > we'd probably have to use some run-time DT patching, which isn't possible
> >> > yet, AFAICS.
> >>
> >> I agree with your reasoning there, though perhaps Laurent or Magnus
> >> have a more enlightened view of things.
> >
> > I'm tempted to say this should be handled by the boot loader, which should
> > then patch the DT accordingly. This is probably just a poor attempt not to
> > solve the problem in Linux though :-)
> 
> This is not the first time we have come to the conclusion that Linux
> need to modify the device tree.

In fact, I'm not even sure we have to select. Please correct me if I'm 
wrong, but to me it looks like that switch switches the SDHI1 (second 
SD-card) interface to either connect to an SD-card connector, or to an 
SDIO WLAN module. Do we really have to distinguish between the two? Cannot 
we just enable the interface and probe the card? Obviously, the card 
detection will not work in the SDIO case. Is this the only difference? If 
so, maybe we could make a special card-detection routine, that would 
return true, if the switch is in SDIO position, and read the real CD pin, 
if the switch activates the slot?

Thanks
Guennadi

> And I clearly remember Grant stating that it is in principle a living
> datastructure, it's not like it's read-only.
> 
> The actual restrictions seem to be more about things like if you
> need to read this GPIO to figure out how to set up the device tree
> you already need the base system initialized to access the GPIO
> so it becomes a chicken-and-egg problem.
> 
> > Linus, do you have an opinion on this ? The board has two connectors (MMC/SD 1
> > and wifi module) that are not usable concurrently. The user can select which
> > connector to use through a hardware switch that existing board code reads at
> > init time to determine which platform devices to register and how to configure
> > pin muxing. Are you aware of a similar problem on other boards that would have
> > been solved already ?
> 
> Just because the pin control tables *can* be initialized from the device
> tree doesn't mean all of them *have to*.
> 
> No more than all devices in the system have to come from the device
> tree. You can still use platform_device_register() and in some cases
> it is the most reasonable thing to do.
> 
> So use the nice auto-detection scheme you have, and use
> pinctrl_register_mappings() from the machine to set up the right
> mapping depending on what was detected. Naturally this needs
> to happen before that MMC/SD or Wifi module gets probed.
> 
> Yours,
> Linus Walleij
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
