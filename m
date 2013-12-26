From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Dec 2013 21:51:34 +0000
Subject: Re: [PATCH V2 2/5] arm: shmobile: r7s72100: add i2c clocks
Message-Id: <CAMuHMdXP4DAF1_DPtNfwCyP8WHFU03=zgM7i8FW9n6tcJpAHHQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-3-git-send-email-wsa@the-dreams.de>
 <20131224024855.GC22401@verge.net.au>
 <CAMuHMdWPZjeF7+nEjXR3vL4HgSEVEk-uf-qQ68ZnFA=+Y_Q8tQ@mail.gmail.com>
 <20131226212539.GA2561@katana>
 <CAMuHMdXF6WmS_j4pC1U5jL3SK-ck7N=EA+-45duXdRZP1cOJkw@mail.gmail.com>
In-Reply-To: <CAMuHMdXF6WmS_j4pC1U5jL3SK-ck7N=EA+-45duXdRZP1cOJkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 26, 2013 at 10:34 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>>> Note that after dropping these lines:
>>>
>>>        CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
>>>        CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
>>>        CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
>>>        CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
>>>
>>> i2c stopped working.
>>
>> ??? Why do you want to drop these lines?
>
> Your v2 dropped them, presumably in response to Sergei's ICKy comments.
> And that's what Simon committed...

Upon checking again, your v2 did contain them, but gmail tried to smart
me out by not showing those few lines.
So it must have been Simon who dropped them, or lost them during rebase?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
