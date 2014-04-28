From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Apr 2014 15:03:48 +0000
Subject: Re: [PATCH] clk: shmobile: clk-mstp: change to using clock-indices
Message-Id: <CAMuHMdUmSj6FPhDLazoXxZD_nasL_A0NE1_h63+53b9sNHer2Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140428132641.GA9590@katana>
In-Reply-To: <20140428132641.GA9590@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Wolfram,

On Mon, Apr 28, 2014 at 3:26 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> +     if (of_find_property(np, "clock-indices", &i))
>> +             idxname = "clock-indices";
>> +     else
>> +             idxname = "renesas,clock-indices";
>
> ...and here in the code? It might also be a tad more intuitive to check

Thanks, a comment never hurts.

> for the depracted binding, and if not found, use the new one as default,
> i.e. switch the logic of the if block. Very minor nit, though.

I think checking for the new one first is the right thing to do.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus TorvaldsH
