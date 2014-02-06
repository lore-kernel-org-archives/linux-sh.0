From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Feb 2014 08:16:25 +0000
Subject: Re: [PATCH v3] sh_eth: add device tree support
Message-Id: <CAMuHMdUrAJOTvUPZXVVK3ZSWL1BhE=uiZq0Yxp8XQuRaAxYnKw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402060258.57025.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201402060258.57025.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Rob Landley <rob@landley.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Thu, Feb 6, 2014 at 12:58 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> +- reg: offset and length of (1) the E-DMAC/feLic register block (required),
> +       (2) the TSU register block (optional).

As there can be 2 regions, have you considered reg-names?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
