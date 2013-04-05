From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 05 Apr 2013 00:20:51 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: Armadillo800EVA: Reference DT implementation
Message-Id: <22754436.RlRTR0YCLS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87txxzk77s.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txxzk77s.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Bastian,

On Thursday 04 April 2013 17:58:40 Bastian Hecht wrote:
> 2013/4/4 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> > Hi Bastian,
> > 
> > Thanks for the patch.
> 
> [snip]
> 
> >> +     /* Touchscreen */
> >> +     gpio_request(GPIO_FN_IRQ10,     NULL); /* TP_INT */
> > 
> > Please, no function GPIO in reference DT implementations.
> 
> As far as I understood the pinctrl framework, we choose preconfigured
> settings (in pfc-r8a7740.c) for each device we want to run. We identify
> these devices by their names, like sh-sci.1. How does that work with devices
> connected to busses like the I2C controller for which we can't know which
> GPIOs we need in advance as it is board dependent?

pfc-r8a7740.c defines pin groups and functions. It's then up to board and DT 
files to map the groups and functions they need to devices. The mappings can 
be selected explicitly by drivers, or, for default mappings, automatically by 
the device core. Please see the eva_pinctrl_map array in arch/arm/mach-
shmobile/board-armadillo800eva.c for mapping examples.

> >> +     gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
> > 
> > The GPIO should be passed to the touchscreen driver through DT. As we have
> > no GPIO DT bindings for the r8a7740 yet, an option would be to pass it
> > through platform data (using OF_DEV_AUXDATA).
> 
> I don't see who would use that data. Does your suggestion include to expand
> the st1232 driver?

There's two options here. The one I was suggesting indeed involved modifying 
the st1232 driver to handle the reset signal explicitly. The other option 
would be to use pinctrl mappings to configure the GPIO. This isn't possible 
yet with the PFC driver but I'm working on it.

> So far I see only that the IRQ number is used to set up the IRQ handler. I
> don't see the connection where the muxing would be done.

-- 
Regards,

Laurent Pinchart

