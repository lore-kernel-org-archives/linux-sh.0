From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Sep 2013 08:50:07 +0000
Subject: Re: [PATCH 1/4] pinctrl: sh-pfc: r8a7790: add pin definitions for the I2C3 interface
Message-Id: <CACRpkdYMGiYzLisWfx_wQtw3Gvi3==0D5o7=BG3jcjH-0ea8gA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742636-11215-1-git-send-email-g.liakhovetski@gmx.de>
	<1378742636-11215-2-git-send-email-g.liakhovetski@gmx.de>
	<CACRpkdbDa5Smpfyneq-SAPYvbxB-ju7-X8kkZ7RFpNcYrcBggg@mail.gmail.com>
	<Pine.LNX.4.64.1309171907220.25596@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309171907220.25596@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Tue, Sep 17, 2013 at 7:10 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Tue, 17 Sep 2013, Linus Walleij wrote:

>> > +/* R8A7790 has 6 banks with 32 GPIOs in each = 192 GPIOs */
>> > +#define ROW_GROUP_A(r) ('Z' - 'A' + 1 + (r))
>> > +#define PIN_NUMBER(r, c) (((r) - 'A') * 16 + (c) + 200)
>> > +#define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
>>
>> You add these #defines but do not use them.
>
> ehm, actually I do:

Argh I was just wrong, forget about this.

Woudl really like Laurent's ACK on this before I apply it though.

Yours,
Linus Walleij
