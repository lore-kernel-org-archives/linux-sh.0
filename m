From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Nov 2013 13:39:28 +0000
Subject: Re: [PATCH 04/05 v2] gpio: em: Use lazy disable
Message-Id: <CACRpkdaePTGShd+rt=Jecd6T+f1Cq_rp_hhL9AejgEh446Js-w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120002259.27342.35575.sendpatchset@w520>
	<20131120002335.27342.16796.sendpatchset@w520>
In-Reply-To: <20131120002335.27342.16796.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed, Nov 20, 2013 at 1:23 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> Set the ->irq_enable() and ->irq_disable() methods to NULL
> to enable lazy disable of interrupts. This by itself provides
> some level of optimization, but is mainly enabled as ground
> work for future Suspend-to-RAM wake up support.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Patch applied.

Yours,
Linus Walleij
