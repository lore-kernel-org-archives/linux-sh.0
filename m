From: Rob Herring <robherring2@gmail.com>
Date: Wed, 02 May 2018 02:32:15 +0000
Subject: Re: [PATCH 3/5] tty: serial: sh-sci: Hide earlycon config question
Message-Id: <CAL_JsqJ0MJRpQR7ECY0bi_KJuOzD4NvL1KCzjPnjaVeifHxXVQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
 <1512047522-16312-4-git-send-email-geert+renesas@glider.be>
 <20180415003420.GU3094@brightrain.aerifal.cx> <CAMuHMdVKMwe_FHQWdC_R2hEUxyksCg7Vo+0knX2J+oEcEgRpEQ@mail.gmail.com>
 <20180415190934.GX3094@brightrain.aerifal.cx>
In-Reply-To: <20180415190934.GX3094@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Apr 15, 2018 at 2:09 PM, Rich Felker <dalias@libc.org> wrote:
> On Sun, Apr 15, 2018 at 08:58:42PM +0200, Geert Uytterhoeven wrote:
>> Hi Rich,
>>
>> On Sun, Apr 15, 2018 at 2:34 AM, Rich Felker <dalias@libc.org> wrote:
>> > On Thu, Nov 30, 2017 at 02:12:00PM +0100, Geert Uytterhoeven wrote:
>> >> Renesas H8/300 and ARM platforms use DT and support earlycon, so most
>> >> users want earlycon support to be enabled.
>> >>
>> >> On SuperH platforms, earlycon is not yet supported.
>> >>
>> >> Hence follow the above rationale to configure the default, unless
>> >> CONFIG_EXPERT is enabled.
>> >>
>> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >> ---
>> >>  drivers/tty/serial/Kconfig | 3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> >> index 0c75562d620feb82..952a2c6a9da08fdd 100644
>> >> --- a/drivers/tty/serial/Kconfig
>> >> +++ b/drivers/tty/serial/Kconfig
>> >> @@ -774,10 +774,11 @@ config SERIAL_SH_SCI_CONSOLE
>> >>       default y
>> >>
>> >>  config SERIAL_SH_SCI_EARLYCON
>> >> -     bool "Support for early console on SuperH SCI(F)"
>> >> +     bool "Support for early console on SuperH SCI(F)" if EXPERT
>> >>       depends on SERIAL_SH_SCI=y
>> >>       select SERIAL_CORE_CONSOLE
>> >>       select SERIAL_EARLYCON
>> >> +     default ARCH_RENESAS || H8300
>> >>
>> >>  config SERIAL_SH_SCI_DMA
>> >>       bool "DMA support"
>> >> --
>> >
>> > Can you clarify what the claim that SuperH does not support earlycon
>> > is based on? My understanding is that users were successfully using
>> > this option on Renesas SH systems, and I'm using it on J2 with the
>> > uartlite earlycon support which I added in 7cdcc29e49. I think if you
>> > want to omit the question it should always default to enabled.
>>
>> This is a patch for a Kconfig option for the Renesas sh-sci driver, which
>> supports the SCI, SCIF, SCIFA, SCIFB, and HSCIF uarts found on various
>> Renesas SoCs.
>>
>> Earlycon is used with DT only. While you are using earlycon on J2, you do
>> use it with a different uart (uartlite). Currently there's no upstream support
>> for using DT on Renesas SuperH SoCs. If this changes, the default for
>> SERIAL_SH_SCI_EARLYCON has to be changed.
>>
>> So none of my patch applies to the current state of SuperH Linux support.
>
> OK, I was under the impression (from users) that it worked on Renesas
> SH devices without DT. If it really doesn't then it doesn't matter
> until DT support for them is added. I've got some hardware to
> experiment with now so I'll see what can be done.

Yes, it works without DT (but maybe that is UART specific). It was
originally an x86 8250 thing.

The main thing you need is either fixmap support or ioremap has to
work before paging_init when early_params are processed.

Rob
