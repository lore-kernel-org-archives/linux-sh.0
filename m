From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Sep 2015 17:55:51 +0000
Subject: Re: [RESEND PATCH v2 1/3] pinctrl: sh-pfc: add macros defining GP ports with config flags
Message-Id: <CAMuHMdXO2GU=5gng9Sz=G-RGLPPpefDfmkW5p3dfMF3YVWediA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442419131-14816-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1442419131-14816-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Thu, Sep 24, 2015 at 6:31 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Sep 21, 2015 at 6:17 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Sep 16, 2015 at 5:58 PM, Ulrich Hecht
>> <ulrich.hecht+renesas@gmail.com> wrote:
>>> PORT_GP_CFG_1 and PORT_GP_CFG_32 work like their non-CFG counterparts
>>> but accept an extra argument with config flags.
>>>
>>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Geert are you collecting these patches now?

Yes I am.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
