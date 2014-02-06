From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 06 Feb 2014 11:52:07 +0000
Subject: Re: [PATCH v3] sh_eth: add device tree support
Message-Id: <52F37767.20607@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402060258.57025.sergei.shtylyov@cogentembedded.com> <CAMuHMdUrAJOTvUPZXVVK3ZSWL1BhE=uiZq0Yxp8XQuRaAxYnKw@mail.gmail.com>
In-Reply-To: <CAMuHMdUrAJOTvUPZXVVK3ZSWL1BhE=uiZq0Yxp8XQuRaAxYnKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Rob Landley <rob@landley.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

Hello.

On 06-02-2014 12:16, Geert Uytterhoeven wrote:

>> +- reg: offset and length of (1) the E-DMAC/feLic register block (required),
>> +       (2) the TSU register block (optional).

> As there can be 2 regions, have you considered reg-names?

    I've been asked already, and so considered them and found them unneeded.

> Gr{oetje,eeting}s,
>                          Geert

WBR, Sergei

