From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 May 2015 08:19:58 +0000
Subject: Re: [PATCH/RFC 00/12] ARM: shmobile: dts: Add overlays for various serial ports
Message-Id: <CAMuHMdXhLUJqpdAZc7X==s6cyeBdf7TVdJi7JtA1jC_V=hEXsQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
	<D9B202C5-6460-4217-9F58-67078C3DB9B1@konsulko.com>
In-Reply-To: <D9B202C5-6460-4217-9F58-67078C3DB9B1@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Pantelis,

On Wed, May 13, 2015 at 10:16 AM, Pantelis Antoniou
<pantelis.antoniou@konsulko.com> wrote:
>>  - The overlay sources use full paths to refer to the device nodes for
>>    creating aliases, as path references (unlike phandle references) are
>>    not yet supported by overlays.
>
> Hmm, phandle references are completely supported. You just have to remember
> to build your base tree with the -@ option to generate the fixups :)

The aliases need _path_ references.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
