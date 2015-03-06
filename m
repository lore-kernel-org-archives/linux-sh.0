From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 06 Mar 2015 11:26:57 +0000
Subject: Re: [PATCH 2/4] pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned long
Message-Id: <CAMuHMdVhD2e2Q9bTwu_r30AUCq4=-GzH=RWp2TFL7tXXz3prJA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
	<1425058685-12956-3-git-send-email-geert+renesas@glider.be>
	<CACRpkdbv8V2DY6DniY5fOaSQNkNZtZQ6G_hrm-vcG9cjFTSAEA@mail.gmail.com>
In-Reply-To: <CACRpkdbv8V2DY6DniY5fOaSQNkNZtZQ6G_hrm-vcG9cjFTSAEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Linus, Laurent,

On Fri, Mar 6, 2015 at 11:48 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Feb 27, 2015 at 6:38 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
>> Register and field widths are in the range 1..32. Storing them in the
>> pinctrl data in (arrays of) unsigned long wastes space.
>>
>> This decreases the size of a (32-bit) shmobile_defconfig kernel
>> supporting 7 SoCs by 26460 bytes.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This 2/4 is not ACKed so pausing application after 1/4.
>
> Is 3,4/4 independent of this patch?

Unfortunately not, as there are contextual dependencies.

Laurent: Is 2/4 OK for you as-is? Your comments about the size of reg are
not related to "Store register/field widths in u8 instead of unsigned long",
and thus an area for future improvement.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
