From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Dec 2013 09:26:17 +0000
Subject: Re: [PATCH 2/2] spi: rspi: Fix typo when clearing SPSR_OVRF
Message-Id: <CAMuHMdWiJPF2NU+ME=CLMygvABZ_fcTyr7ggdQtFKbOGhCA0+w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
	<1387823664-32318-2-git-send-email-geert+renesas@linux-m68k.org>
	<20131224025936.GF22401@verge.net.au>
In-Reply-To: <20131224025936.GF22401@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Tue, Dec 24, 2013 at 3:59 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 23, 2013 at 07:34:24PM +0100, Geert Uytterhoeven wrote:
>> The overrun flag should be cleared in the SPI Status Register, not in the
>> SPI Control Register, based on the SDK sample code.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>
> I don't believe that I have access to the sample code,
> but I do trust your judgement.

It's in the public RZLSP-V1.0.1 for RZ/A1H, available from
https://oss.renesas.com/. Oh, today a new version got released.

The issue is quite obvious: after clearing the bit, the new value should
be written back to the same register.

However, the fix is not in a v3.10-rc6 version I saw, so this may matter
for LTSI.

> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
