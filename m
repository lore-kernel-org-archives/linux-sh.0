From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 23 Jan 2013 14:59:09 +0000
Subject: Re: [PATCH v2 03/29] drivers/pinctrl: grab default handles from device core
Message-Id: <Pine.LNX.4.64.1301231555330.26301@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1357692769-1432-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357692769-1432-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all

On Wed, 9 Jan 2013, Laurent Pinchart wrote:

> From: Linus Walleij <linus.walleij@linaro.org>

I think, this patch should be fixed by merging the following addition into 
it:

https://patchwork.kernel.org/patch/1991131/

Thanks
Guennadi

> 
> This makes the device core auto-grab the pinctrl handle and set
> the "default" (PINCTRL_STATE_DEFAULT) state for every device
> that is present in the device model right before probe. This will
> account for the lion's share of embedded silicon devcies.
> 
> A modification of the semantics for pinctrl_get() is also done:
> previously if the pinctrl handle for a certain device was already
> taken, the pinctrl core would return an error. Now, since the
> core may have already default-grabbed the handle and set its
> state to "default", if the handle was already taken, this will
> be disregarded and the located, previously instanitated handle
> will be returned to the caller.
> 
> This way all code in drivers explicitly requesting their pinctrl
> handlers will still be functional, and drivers that want to
> explicitly retrieve and switch their handles can still do that.
> But if the desired functionality is just boilerplate of this
> type in the probe() function:
> 
> struct pinctrl  *p;
> 
> p = devm_pinctrl_get_select_default(&dev);
> if (IS_ERR(p)) {
>    if (PTR_ERR(p) = -EPROBE_DEFER)
>         return -EPROBE_DEFER;
>         dev_warn(&dev, "no pinctrl handle\n");
> }
> 
> The discussion began with the addition of such boilerplate
> to the omap4 keypad driver:
> http://marc.info/?l=linux-input&m5091157719300&w=2
> 
> A previous approach using notifiers was discussed:
> http://marc.info/?l=linux-kernel&m5263661110528&w=2
> This failed because it could not handle deferred probes.
> 
> This patch alone does not solve the entire dilemma faced:
> whether code should be distributed into the drivers or
> if it should be centralized to e.g. a PM domain. But it
> solves the immediate issue of the addition of boilerplate
> to a lot of drivers that just want to grab the default
> state. As mentioned, they can later explicitly retrieve
> the handle and set different states, and this could as
> well be done by e.g. PM domains as it is only related
> to a certain struct device * pointer.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Mitch Bradley <wmb@firmworks.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Rickard Andersson <rickard.andersson@stericsson.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Only store a pointer in the device struct, and only allocate
>   this if it's really used by the device.
> - Seeking ACK on this from Greg (and others who like it) so I
>   can merge it through the pinctrl subsystem.
> ---
>  Documentation/pinctrl.txt       |   24 ++++++++++-
>  drivers/base/Makefile           |    1 +
>  drivers/base/dd.c               |    7 +++
>  drivers/base/pinctrl.c          |   81 +++++++++++++++++++++++++++++++++++++++
>  drivers/pinctrl/core.c          |   11 ++++-
>  include/linux/device.h          |    7 +++
>  include/linux/pinctrl/devinfo.h |   45 +++++++++++++++++++++
>  7 files changed, 171 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/base/pinctrl.c
>  create mode 100644 include/linux/pinctrl/devinfo.h

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
