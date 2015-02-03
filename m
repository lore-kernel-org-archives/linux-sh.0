From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 03 Feb 2015 19:49:54 +0000
Subject: Re: [RFC 0/5] r8a7790: lager: add support for RCLK watchdog
Message-Id: <CAMuHMdXCYyrbUg9mi=7zDghG457dzFUCjPBUBZkooCQegdwp+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Tue, Feb 3, 2015 at 8:04 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Feb 02, 2015 at 12:50:24PM +0100, Geert Uytterhoeven wrote:
>> Hi Wolfram,
>>
>> On Mon, Feb 2, 2015 at 12:24 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> >> I've just tried your series on Koelsch, and it suffers from the same problem.
>> >> Does it work on Lager for both CONFIG_SMP=y and CONFIG_SMP=n?
>> >
>> > I didn't. And what a surprise, it fails with SMP=y :( I'll having a
>> > look...
>>
>> Good luck!
>
> Weelllll....
>
> I think there are multiple issues and they mostly come from the fact
> that a watchdog reset does not initialize the RST module. Rebooting even
> fails when I only use CPU0 with SMP=y. I could fix this very hackish by
> resetting the A15 boot address (CA15BAR) to the default value in the
> watchdog probe function. That alone sadly doesn't help. Once I activate
> the other CPUs, it will still lock up.
>
> Pity, but before I get too side-tracked from what I originally wanted to
> do, it seems that I simply have to run my tests with SMP=n. I guess this
> also renders the watchdog driver pretty useless for upstream now :(

Indeed. Unfortunately your findings are 100% in-line with mine.
Thanks for confirming!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
