From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 26 Apr 2010 06:50:11 +0000
Subject: Re: Hi guys, does any of you have experience with touchscreen controllers?
Message-Id: <201004260850.11481.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201004222004.38724.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004222004.38724.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Dale, 
maybe I need to be more clear about my condition.
1) I connected the ads7843 to general I/O ports because the SPIs available on 
sh2a7203 have been be used for other functions;
2) My real problem is the following: I wrote an ADS7843 device driver as a 
button driver of the input subsystem. I configured the ads7843 with INT 
enabled; so when the touch is pressed I have a burst of IRQ. The IRQ handler 
read the ads7843 and return to the input subsystem the abs values of the 
touchscreen.
The user program open the file /dev/input/event0 and with the select waits for 
data; what I see is: during all the time I have a finger on the touch only IRQ 
handler is exeuted and no action is done in the user program. I tried also 
opening /dev/input/event0 with O_NONBLOCK flag but nothing changes.

Did you use the ads7843 with INT enabled or not?
And if yes, using the falling edge or the low level?

Thanks

In data domenica 25 aprile 2010 04:26:51, Dale Larson ha scritto:
: > Fabio Giovagnini wrote:
> > I'm working with ADS7843 and I have some troubles to get only the push
> > event on the screen.
> > If any of you knows a better place where to talk about this argument it
> > will be appreciated very much to tell me.
> >
> > Best regards
> 
> Hi Fabio,
> 
> I've dealt with that chip for our 7760 board. The key is to provide a pen
> poll function so pen up can be detected. Here's the way I defined it in the
> platform bsp stuff:
> 
> 
> 
> #include <linux/spi/spi.h>
> #include <linux/spi/ads7846.h>
> 
> 
> /* SPI devices - Touch Screen */
> 
> static int ads7843_pendown_state(void)
> {
>       return (ctrl_inb(PGDR) & 0x40) ? 0 : 1;
> }
> 
> static struct ads7846_platform_data ads_info = {
>      .model              = 7843,
>      .x_min              = 150,
>      .x_max              = 3830,
>      .y_min              = 190,
>      .y_max              = 3830,
>      .vref_delay_usecs   = 100,
>      .keep_vref_on       = 1,
>      .x_plate_ohms       = 576,
>      .y_plate_ohms       = 366,
>      .pressure_max       = 15000,    /* Generally nonsense on the 7843 */
>      .debounce_max       = 1,
>      .debounce_rep       = 0,
>      .debounce_tol       = (~0),
>      .get_pendown_state  = ads7843_pendown_state,
> };
> 
> static struct spi_board_info jcinap_spi_devices[] = {
>      {
>          /* Touchscreen controller */
>          .modalias       = "ads7846",
>          .chip_select    = 0,
>          .bus_num        = 0,
>          .max_speed_hz   = 1000000,   /* 1Mhz */
>          .platform_data  = &ads_info,
>          .irq            = 11
>      },
> };
> 
> 
> 
> In the init code:
> 
> 
> 
> /* Register the SPI devices */
> spi_register_board_info(jcinap_spi_devices,
>  ARRAY_SIZE(jcinap_spi_devices));
> 
> 
> 
> Dale Larson
> Johnson Controls, Inc
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
