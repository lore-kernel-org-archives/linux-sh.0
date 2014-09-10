From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Sep 2014 12:37:46 +0000
Subject: Re: [PATCH/RFC 4/5] ARM: shmobile: R-Mobile: Add DT support for PM domains
Message-Id: <CAMuHMdVz4QiRBHN43TE1-+R_zDouNMpTbak1rfmOmT4Vv0Lvxg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410183344-14756-1-git-send-email-geert+renesas@glider.be>
 <1410183344-14756-5-git-send-email-geert+renesas@glider.be>
 <7hfvg0kdk2.fsf@deeprootsystems.com>
In-Reply-To: <7hfvg0kdk2.fsf@deeprootsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Tue, Sep 9, 2014 at 5:40 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> +static int r8a7740_pd_a4s_suspend(void)
>> +{
>> +     /*
>> +      * The A4S domain contains the CPU core and therefore it should
>> +      * only be turned off if the CPU is in use.
>
> I think you meant "if the CPU is *not* in use."  ?  :)

Ah, this was copied from pm-r8a7740.c, which was copied from pm-sh7372.c.
The thinko has been fixed in the latter, when more advanced suspend support
was added.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
