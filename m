From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 22 Dec 2017 11:56:07 +0000
Subject: Re: [PATCH v1 05/10] arch: sh: migor: Use new renesas-ceu camera driver
Message-Id: <5334251.lvKN80GZGW@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1510743363-25798-1-git-send-email-jacopo+renesas@jmondi.org> <1742042.6TTT7UTHfg@avalon> <20171221203125.GH27115@w540>
In-Reply-To: <20171221203125.GH27115@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, magnus.damm@gmail.com, geert@glider.be, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Jacopo,

On Thursday, 21 December 2017 22:31:25 EET jacopo mondi wrote:
> On Tue, Dec 12, 2017 at 12:00:43PM +0200, Laurent Pinchart wrote:
> > On Wednesday, 15 November 2017 12:55:58 EET Jacopo Mondi wrote:
> >> Migo-R platform uses sh_mobile_ceu camera driver, which is now being
> >> replaced by a proper V4L2 camera driver named 'renesas-ceu'.
> >> 
> >> Move Migo-R platform to use the v4l2 renesas-ceu camera driver
> >> interface and get rid of soc_camera defined components used to register
> >> sensor drivers.
> >> 
> >> Also, memory for CEU video buffers is now reserved with membocks APIs,
> >> and need to be declared as dma_coherent during machine initialization to
> >> remove that architecture specific part from CEU driver.
> >> 
> >> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >> ---
> >> 
> >>  arch/sh/boards/mach-migor/setup.c | 164 ++++++++++++++++---------------
> >>  1 file changed, 76 insertions(+), 88 deletions(-)
> >> 
> >> diff --git a/arch/sh/boards/mach-migor/setup.c
> >> b/arch/sh/boards/mach-migor/setup.c index 98aa094..10a9b3c 100644
> >> --- a/arch/sh/boards/mach-migor/setup.c
> >> +++ b/arch/sh/boards/mach-migor/setup.c
> >> @@ -27,7 +27,7 @@
> >>  #include <linux/videodev2.h>
> >>  #include <linux/sh_intc.h>
> >>  #include <video/sh_mobile_lcdc.h>
> >> -#include <media/drv-intf/sh_mobile_ceu.h>
> >> +#include <media/drv-intf/renesas-ceu.h>
> >>  #include <media/i2c/ov772x.h>
> >>  #include <media/soc_camera.h>
> >>  #include <media/i2c/tw9910.h>
> >> @@ -308,62 +308,80 @@ static struct platform_device migor_lcdc_device > >> {
> >>  static struct clk *camera_clk;
> >>  static DEFINE_MUTEX(camera_lock);
> >> 
> >> -static void camera_power_on(int is_tw)
> >> +static void camera_vio_clk_on(void)
> >>  {
> >> -	mutex_lock(&camera_lock);
> >> -
> >>  	/* Use 10 MHz VIO_CKO instead of 24 MHz to work
> >>  	 * around signal quality issues on Panel Board V2.1.
> >>  	 */
> >>  	camera_clk = clk_get(NULL, "video_clk");
> >>  	clk_set_rate(camera_clk, 10000000);
> >>  	clk_enable(camera_clk);	/* start VIO_CKO */
> >> -
> >> -	/* use VIO_RST to take camera out of reset */
> >> -	mdelay(10);
> >> -	if (is_tw) {
> >> -		gpio_set_value(GPIO_PTT2, 0);
> >> -		gpio_set_value(GPIO_PTT0, 0);
> >> -	} else {
> >> -		gpio_set_value(GPIO_PTT0, 1);
> >> -	}
> >> -	gpio_set_value(GPIO_PTT3, 0);
> >> -	mdelay(10);
> >> -	gpio_set_value(GPIO_PTT3, 1);
> >> -	mdelay(10); /* wait to let chip come out of reset */
> >>  }
> >> 
> >> -static void camera_power_off(void)
> >> +static void camera_disable(void)
> >>  {
> >> -	clk_disable(camera_clk); /* stop VIO_CKO */
> >> +	/* stop VIO_CKO */
> >> +	clk_disable(camera_clk);
> >> 
> >>  	clk_put(camera_clk);
> >> 
> >> +	gpio_set_value(GPIO_PTT0, 0);
> >> +	gpio_set_value(GPIO_PTT2, 1);
> >>  	gpio_set_value(GPIO_PTT3, 0);
> >> +
> >>  	mutex_unlock(&camera_lock);
> >>  }
> >> 
> >> -static int ov7725_power(struct device *dev, int mode)
> >> +static void camera_reset(void)
> >>  {
> >> -	if (mode)
> >> -		camera_power_on(0);
> >> -	else
> >> -		camera_power_off();
> >> +	/* use VIO_RST to take camera out of reset */
> >> +	gpio_set_value(GPIO_PTT3, 0);
> >> +	mdelay(10);
> >> +	gpio_set_value(GPIO_PTT3, 1);
> >> +	mdelay(10);
> >> +}
> >> +
> >> +static int ov7725_enable(void)
> >> +{
> >> +	mutex_lock(&camera_lock);
> >> +	camera_vio_clk_on();
> >> +	mdelay(10);
> >> +	gpio_set_value(GPIO_PTT0, 1);
> >> +
> >> +	camera_reset();
> >> 
> >>  	return 0;
> >>  }
> >> 
> >> -static int tw9910_power(struct device *dev, int mode)
> >> +static int tw9910_enable(void)
> >>  {
> >> -	if (mode)
> >> -		camera_power_on(1);
> >> -	else
> >> -		camera_power_off();
> >> +	mutex_lock(&camera_lock);
> >> +	camera_vio_clk_on();
> >> +	mdelay(10);
> >> +	gpio_set_value(GPIO_PTT2, 0);
> > +
> >> +	camera_reset();
> >> 
> >>  	return 0;
> >>  }
> > 
> > After studying the schematics, and if you can confirm that R26 is not
> > mounted on the panel board, I think all this could be handled by the
> > OV7720 and TW9910 drivers.
> > 
> > The clock is easy, it's used by the OV7720 only, just expose it as the
> > input clock for that device. On a side note, your ov772x driver in this
> > series tries to get a clock named "mclk", but it should be named "xclk"
> > as that's how the chip's input signal is named. The TW9910 has its own
> > crystal oscillator so it won't be affected. As a bonus point the clock
> > will remain off when capturing from the TW9910.
> 
> I'm sorry, this is surely naive, but I never really worked with board
> files before. I see two options for achieving what you proposed here
> 
> 1) clk_get("video_clk") in migor/setup.c and add the returned "struct
> clk" to "struct ov7725_info" and in the sensor driver use that clock
> 
> 2) clk_get("xclk") in drivers/../ov772x.c
>    The only way I found to add that clock would be to register a
>    "struct clk_lookup" with "clkdev_add()" in migor/setup.c

And that's exactly how it's supposed to be done :-)

> 3) Something else I haven't learned yet
> 
> > The TV_IN_EN and CAM_EN signals (PTT2 and PTT0 GPIOs respectively)
> > shouldn't be difficult either. You can expose them as the PDN and PWDN
> > GPIOs for the OV7720 and TW9910 and handle them in the respective
> > drivers. CAM_EN also controls the digital video bus multiplexing, and
> > unless I'm mistaken it will just work as a side effect of power down
> > signal control as long as you make sure that the OV7720 remains in power
> > down when not selected as the CEU input.
> 
> Same as above, should I "gpio_request" or even better use the new
> "gpiod_" APIs in setup.c and pass to driver the result of the request
> or should I request the gpios in the drivers?

You should request the gpios (using the gpiod API) in the drivers, so that DT 
and non-DT platforms will be supported the same way.

> > The VIO_RST signal (PTT3 GPIO) is a bit more annoying, as it is shared by
> > both the OV7720 and TW9910 as their reset signal, and as far as I know
> > GPIOs can't be easily shared between drivers.
> > 
> > Using a reset controller might be an option but I can't see any reset
> > controller driver for GPIOs. https://patchwork.kernel.org/patch/3978091/
> > seems not to have been merged. This being said, having to instantiate a
> > reset controller to share a GPIO is annoying, I wonder if it would make
> > sense to add support for shared GPIOs in the GPIO core.
> > 
> > Another option could be to only request the reset GPIO when needed instead
> > of doing so at probe time.
> 
> So that implies passing to drivers the gpio index and request/release
> everytime? Aren't we pushin a platform specific thing in sensor
> drivers this way?

The need to share GPIOs isn't restricted to this platform, even if it doesn't 
occur on every platform. We should ideally support this in a way that is as 
transparent as possible for drivers, which is why I mentioned reset 
controllers or adding GPIO sharing support in the GPIO core.

Requesting and releasing the GPIOs on demand is more of a hack, but requesting 
the GPIOs in the driver is certainly the way to go, which is traditionally 
done at probe time.

-- 
Regards,

Laurent Pinchart

