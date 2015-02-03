From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 03 Feb 2015 12:12:31 +0000
Subject: Re: [RFC 4/5] ARM: shmobile: r8a7790: let rst module allow watchdog resets if desired
Message-Id: <CAMuHMdXUKxVNwUVjE5N=a14ev6LiA7fSV5XHfvwftnXkQZzBcA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Mon, Feb 2, 2015 at 12:13 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> It's slightly more complicated there, as we already have a driver for the
>> SYSC on R-Mobile (rmobile-reset), and a device node can't be bound
>> by both the syscon and the rmobile-reset driver.
>
> Is it just complicated or is it an open issue how to handle that?

If the syscon drivers binds against the device, rmobile-reset can no
longer bind against it. One solution is to convert rmobile-reset to use
syscon, so both the rwdt and the rmobile-reset drivers would access it
through syscon.
But currently syscon provides access to the first register bank of a device
only, while the RESCNT register is part of the second bank.

>> Do you have a better idea?
>
> Nope. I also thought that something like syscon must be used if the
> initialization in arch-code won't work. Still, I tried first with the
> least intrusive version :)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
