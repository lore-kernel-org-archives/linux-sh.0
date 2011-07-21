From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 21 Jul 2011 07:54:32 +0000
Subject: Re: [PATCH 1/2] sh-mobile: enable both edges GPIO interrupts on sh7372
Message-Id: <20110721075432.GE27831@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange> <Pine.LNX.4.64.1107151254300.22613@axis700.grange> <Pine.LNX.4.64.1107151256380.22613@axis700.grange> <CANqRtoRin_mSERnYn8Q-dYJHc0O-kwa3YtmjCRDsUU=yEfDMEw@mail.gmail.com>
In-Reply-To: <CANqRtoRin_mSERnYn8Q-dYJHc0O-kwa3YtmjCRDsUU=yEfDMEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

On Fri, Jul 15, 2011 at 08:14:23PM +0900, Magnus Damm wrote:
> On Fri, Jul 15, 2011 at 7:58 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > From: Magnus Damm <damm@opensource.se>
> >
> > IRQ-capable GPIOs on sh7372 can be configured to produce interrupts on
> > both edges.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Magnus Damm <damm@opensource.se>
> > ---
> > ?drivers/sh/intc/chip.c | ? ?3 +++
> > ?1 files changed, 3 insertions(+), 0 deletions(-)
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
