From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 06 Mar 2015 12:44:13 +0000
Subject: Re: [PATCH v3] sh-pfc: add R8A7794 PFC support
Message-Id: <54F9A11D.3070100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2084538.pWCX8EzoLe@wasted.cogentembedded.com> <CACRpkdbjhyhci_O8ecCTM3du+k8NRTyw026mie5OTorXJO1P+Q@mail.gmail.com>
In-Reply-To: <CACRpkdbjhyhci_O8ecCTM3du+k8NRTyw026mie5OTorXJO1P+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?B?UGF3ZcWCIE1vbGw=?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 3/6/2015 1:34 PM, Linus Walleij wrote:

>> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

>> Add PFC support for  the  R8A7794 SoC  including pin groups for some on-chip
>> devices such as ETH, I2C, INTC, MSIOF, QSPI, [H]SCIF...

>> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> [Sergei: squashed together several patches, fixed the MLB_CLK typo, added IRQ4..
>> IRQ9 pin groups,  fixed IRQn comments, added ETH B pin group names, removed
>> stray new line and fixed typos in the  comments in the pinmux_config_regs[]
>> initializer, removed the platform device ID, took into account limited number of
>> signals in the GPIO1/5/6 controllers, added reasonable and removed unreasonable
>> copyrights, modified the bindings document, renamed, added changelog.]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> Changes in version 3:

> This v3 applied with Laurent's ACK.

    There's v4 already. Anyway, it shouldn't be applied yet.

> Yours,
> Linus Walleij

WBR, Sergei

