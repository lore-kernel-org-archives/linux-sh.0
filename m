From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Apr 2014 21:26:07 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <CAMuHMdV3xExVZ_bDduF8BHiTW7fDP1EAgujhBRirXAFu0c09kA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Apr 21, 2014 at 11:09 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> Last time I tried together with "of: Enable console on serial ports
>> specified by /chosen/stdout-path", which allows to boot without any
>> "console=" parameters at all.
>
> That's a nice patch, I wasn't aware of it.

You probably want to apply the other parts from the series
"[RFC 0/5] of: Automatic console registration cleanups" as well.

> How is the baud rate selected in that case ?

Funny, I was also wondering when I first saw the series, and it motivated me
to give it a try ;-)

drivers/tty/serial/sh-sci.c:serial_console_setup():

static int serial_console_setup(struct console *co, char *options)
{
        struct sci_port *sci_port;
        struct uart_port *port;
        int baud = 115200;
        int bits = 8;
        int parity = 'n';
        int flow = 'n';

In the absence of any user-specified parameters, it uses the defaults above.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
