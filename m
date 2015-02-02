From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Feb 2015 11:50:24 +0000
Subject: Re: [RFC 0/5] r8a7790: lager: add support for RCLK watchdog
Message-Id: <CAMuHMdWUhok3TNzrMF8BiK7mS=RgkdBgMm3K-N5m6CQ3UHyfhw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Mon, Feb 2, 2015 at 12:24 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> I've just tried your series on Koelsch, and it suffers from the same problem.
>> Does it work on Lager for both CONFIG_SMP=y and CONFIG_SMP=n?
>
> I didn't. And what a surprise, it fails with SMP=y :( I'll having a
> look...

Good luck!

>> The differences are small: the variant with 8-bit registers has a smaller
>> maximum timeout, and no magic value to be stored in the upper bits.
>
> Do they also have 32kHz as input clock? Then they do need a ping every
> 8ms! Those should use the shwdt driver then which pings the device
> frequently and runs a software watchdog on top to cope with the usual
> watchdog granularity which is in the second range.

Yes, 32 kHz. But you still have the Clock Select and Expanded Clock Select
bits to increase the timeout.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
