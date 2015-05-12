From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 May 2015 07:45:58 +0000
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: r8a73a4: Remove obsolete multi-platform check
Message-Id: <CAMuHMdV0Egnyr-1ZQtgC7t0GPzTrVj9_ndpjHoLmAj9U9sR28w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430216072-31412-1-git-send-email-geert+renesas@glider.be>
	<CACRpkdZZ_=x7=2Ae9VPAo6dPvD2D_2MUDwNjCF-jxSp075X1hA@mail.gmail.com>
In-Reply-To: <CACRpkdZZ_=x7=2Ae9VPAo6dPvD2D_2MUDwNjCF-jxSp075X1hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, May 12, 2015 at 9:26 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Apr 28, 2015 at 12:14 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
>> As of commit 9d07d414d4c33d86 ("ARM: shmobile: r8a73a4: ape6evm: Remove
>> legacy platform"), r8a73a4 is only supported in generic ARM
>> multi-platform builds.  Hence CONFIG_ARCH_MULTIPLATFORM is always set,
>> and the check can be removed.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> This depends on Simon's branch r8a73a4-ccf-and-multiplatform-for-v4.1

> I guess I can't merge it to pinctrl then and Simon will take it?

Sorry for the confusion, that was a old comment I forgot to remove, as
that branch was already upstream.
The comment was no longer there in the updated version, sent 1 minute later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
