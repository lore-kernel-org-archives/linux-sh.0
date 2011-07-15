From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 15 Jul 2011 11:14:23 +0000
Subject: Re: [PATCH 1/2] sh-mobile: enable both edges GPIO interrupts on sh7372
Message-Id: <CANqRtoRin_mSERnYn8Q-dYJHc0O-kwa3YtmjCRDsUU=yEfDMEw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
	<Pine.LNX.4.64.1107151254300.22613@axis700.grange>
	<Pine.LNX.4.64.1107151256380.22613@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1107151256380.22613@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

On Fri, Jul 15, 2011 at 7:58 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> From: Magnus Damm <damm@opensource.se>
>
> IRQ-capable GPIOs on sh7372 can be configured to produce interrupts on
> both edges.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <damm@opensource.se>
> ---
> =A0drivers/sh/intc/chip.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)

Acked-by: Magnus Damm <damm@opensource.se>
