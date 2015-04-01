From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 01 Apr 2015 12:17:47 +0000
Subject: Re: [PATCH v2 2/4] Documentation: i2c: describe the new slave mode
Message-Id: <CAMuHMdVVLVXmbtan1rKtDrSrJ_nKO_K5Xx4jAjcb5ow_ChDVhg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
	<1427099199-3628-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1427099199-3628-3-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Hi Wolfram,

On Mon, Mar 23, 2015 at 9:26 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- /dev/null
> +++ b/Documentation/i2c/slave-interface

> +I2C slave events
> +----------------
> +
> +The bus driver sends an event to the backend using the following function:
> +
> +       ret = i2c_slave_event(client, event, &val)
> +
> +'client' describes the i2c slave device. 'event' is one of the special event
> +types described hereafter. 'val' holds an u8 value for the data byte to be
> +read/written and is thus bidirectional. The pointer to val must always be
> +provided even if val is not used for an event, i.e. don't use NULL here. 'ret'
> +is the return value from the backend. Mandatory events must be provided by the
> +bus drivers and must be checked for by backend drivers.
> +
> +Event types:
> +
> +* I2C_SLAVE_WRITE_REQUESTED (mandatory)
> +
> +'val': unused
> +'ret': always 0
> +
> +Another I2C master wants to write data to us. This event should be sent once
> +our own address and the write bit was detected. The data did not arrive yet, so
> +there is nothing to process or return. Wakeup or initialization probably needs
> +to be done, though.
> +
> +* I2C_SLAVE_READ_REQUESTED (mandatory)

I'm wondering whether these should be called I2C_SLAVE_READ_FIRST...

> +'val': backend returns first byte to be sent
> +'ret': always 0
> +
> +Another I2C master wants to read data from us. This event should be sent once
> +our own address and the read bit was detected. After returning, the bus driver
> +should transmit the first byte.
> +
> +* I2C_SLAVE_WRITE_RECEIVED (mandatory)
> +
> +'val': bus driver delivers received byte
> +'ret': 0 if the byte should be acked, some errno if the byte should be nacked
> +
> +Another I2C master has sent a byte to us which needs to be set in 'val'. If 'ret'
> +is zero, the bus driver should ack this byte. If 'ret' is an errno, then the byte
> +should be nacked.
> +
> +* I2C_SLAVE_READ_PROCESSED (mandatory)

... and I2C_SLAVE_READ_NEXT?

I don't have good alternative names for the write operation, as it's not
symmetric.

> +'val': backend returns next byte to be sent
> +'ret': always 0
> +
> +The bus driver requests the next byte to be sent to another I2C master in
> +'val'. Important: This does not mean that the previous byte has been acked, it
> +only means that the previous byte is shifted out to the bus! To ensure seamless
> +transmission, most hardware requests the next byte when the previous one is
> +still shifted out. If the master sends NACK and stops reading after the byte
> +currently shifted out, this byte requested here is never used. It very likely
> +needs to be sent again on the next I2C_SLAVE_READ_REQUEST, depending a bit on
> +your backend, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
