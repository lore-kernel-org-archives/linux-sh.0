From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Aug 2015 13:17:03 +0000
Subject: Re: [PATCH 08/10] i2c: support 10 bit and slave addresses in sysfs 'new_device'
Message-Id: <CAMuHMdWfL3SwzZ=Wu5X96Npf9RHmVWc7o7R+uLfvuiRRSpQR9w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
	<1439066007-13951-9-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439066007-13951-9-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>

Hi Wolfram,

On Sat, Aug 8, 2015 at 10:33 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> diff --git a/Documentation/i2c/slave-interface b/Documentation/i2c/slave-interface
> index 2dee4e2d62df19..61ed05cd95317f 100644
> --- a/Documentation/i2c/slave-interface
> +++ b/Documentation/i2c/slave-interface
> @@ -31,10 +31,13 @@ User manual
>  =====>
>  I2C slave backends behave like standard I2C clients. So, you can instantiate
> -them as described in the document 'instantiating-devices'. A quick example for
> -instantiating the slave-eeprom driver from userspace at address 0x64 on bus 1:
> +them as described in the document 'instantiating-devices'. The only difference
> +is that i2c slave backends have their own address space. So, you have to add
> +0x1000 to the address you would originally request. An example for
> +instantiating the slave-eeprom driver from userspace at the 7 bit address 0x64
> +on bus 1:
>
> -  # echo slave-24c02 0x64 > /sys/bus/i2c/devices/i2c-1/new_device
> +  # echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-1/new_device

Does 0x64 still work? It's an ABI since v4.1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
