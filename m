From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2014 08:55:58 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2
Message-Id: <CAMuHMdXoiX6CreDJNaDHcmsifX0C+TRRvTy4JWYBc2c-MVT_Qw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
	<1415274730-310-2-git-send-email-geert+renesas@glider.be>
	<20141107052420.GA1278@katana>
	<20141112014450.GC11597@verge.net.au>
	<CAMuHMdUUspG8-dYGiO7cmuECBLpfmQAYg=B8ZpajxRXhaEUJ2A@mail.gmail.com>
In-Reply-To: <CAMuHMdUUspG8-dYGiO7cmuECBLpfmQAYg=B8ZpajxRXhaEUJ2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Nov 12, 2014 at 9:53 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>>   i2c_shmobile support.") in v2.6.37.
>>
>>   Without this fix i2c may not operate correctly on the sh73a0/kzm9g.
>
> Thanks, that's correct.

git tag --contains b028f94b76319e1b8 says v2.6.38.

Not that you're gonna backport it to ltsi-v2.6.37 ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
