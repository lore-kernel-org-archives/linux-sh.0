From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Sep 2015 12:24:44 +0000
Subject: Re: [PATCH/RFC 08/12] ARM: shmobile: koelsch dts: Add overlay for SCIFB1 on EXIO A
Message-Id: <CAMuHMdWOB2BeWB4MpxBksg_Sp5Vic0DhQk4dc1aGF9zTeQbo9A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
	<1431452235-11692-9-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-9-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, May 12, 2015 at 7:37 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Provide access to SCIFB1 on EXIO Connector A.
>
> FIXME SCIFB1 TX works, RX doesn't.

FTR, fixed by "[PATCH] pinctrl: sh-pfc: r8a7791/r8a7793: Correct SCIFB1_B SCK
MOD_SEL value" (http://thread.gmane.org/gmane.linux.kernel.gpio/10523).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
