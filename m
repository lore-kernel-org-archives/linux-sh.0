From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 06 Oct 2014 08:43:28 +0000
Subject: Re: [PATCH v2 03/13] ARM: shmobile: kzm9d dts: Add chosen/stdout-path
Message-Id: <CAMuHMdUq1ivb0iQ=9YbVc5-BcqxVQ_SyqAkpBKn2X4Uq9WK5Mg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412349104-18724-1-git-send-email-geert+renesas@glider.be>
	<1412349104-18724-4-git-send-email-geert+renesas@glider.be>
	<20141006023650.GA23099@verge.net.au>
In-Reply-To: <20141006023650.GA23099@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Simon,

On Mon, Oct 6, 2014 at 4:36 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Oct 03, 2014 at 05:11:34PM +0200, Geert Uytterhoeven wrote:
>> Add a stdout-path property so that automatic console selection works
>> in the absence of a "console=" parameter on the kernel command line.
>>
>> Remove the now-superfluous "console=" parameter from chosen/bootargs.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> In my environment the bootargs portion of this change results
> in no console output. I am guessing that this is because the
> console starts with a different terminal speed (though which speed
> I am unsure).
>
> If my guess is correct then strictly speaking this is not a bug,
> though it is a behavioural change. And as such I think at the very
> least it needs some discussion.

I forgot emev is the only supported SoC not using sh-sci.
drivers/tty/serial/sh-sci.c:serial_console_setup() defaults to 115200 baud,
while serial8250_console_setup() defaults to 9600 baud.

So we have to keep the console= parameter. Will resend.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
