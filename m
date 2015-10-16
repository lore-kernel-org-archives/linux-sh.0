From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Oct 2015 06:42:14 +0000
Subject: Re: [PATCH v3] DT: mmc: sh_mmcif: fix "compatible" property text
Message-Id: <CAMuHMdXoXQKFS4Z6k4n6dfhgLbMzzVhURyZ=HxVoQFZRaeZu5w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
	<2188985.g7lrY44qCa@wasted.cogentembedded.com>
In-Reply-To: <2188985.g7lrY44qCa@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Fri, Oct 16, 2015 at 12:39 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The "compatible" property text contradicts even the example given in the MMCIF
> binding document itself;  moreover, the Renesas MMCIF driver only matches  on
> the generic "compatible" string and doesn't look for the SoC specific strings
> at all. Thus describe "renesas,sh-mmcif" as a fallback value.
>
> Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
