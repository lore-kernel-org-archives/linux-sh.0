From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Jun 2015 06:05:34 +0000
Subject: Re: [PATCH v2 3/6] pinctrl: sh-pfc: r8a7790: Add separate functions for SDHI 1.8V operation
Message-Id: <CACRpkdbcrW-AQxpBd-w-FrBKZ8tDTtkeAG_mutYOqk8mNV1LJQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1433892104.12074.49.camel@codethink.co.uk>
	<34148355.aYdSK9R7Ck@avalon>
	<1434328840.25446.50.camel@codethink.co.uk>
	<11872302.fE1vlhM93k@avalon>
In-Reply-To: <11872302.fE1vlhM93k@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Mon, Jun 15, 2015 at 4:02 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> On a side note, I have a patch to support the standard "groups", "functions"
> and "pins" properties instead of the Renesas-specific versions, I'll try to
> revive it.

Yes please :)

Makes things a little less confusing in this confusing boundary between
electronics and code...

Yours,
Linus Walleij
