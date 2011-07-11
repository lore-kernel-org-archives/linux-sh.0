From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Jul 2011 06:07:06 +0000
Subject: Re: [PATCH 1/2] i2c: i2c-riic: add support for Renesas RIIC
Message-Id: <20110711060705.GK24169@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E0D1C3A.4050305@renesas.com> <20110711055221.GJ24169@linux-sh.org> <20110711080335.6e191b6e@endymion.delvare>
In-Reply-To: <20110711080335.6e191b6e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, ben-linux@fluff.org, linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

On Mon, Jul 11, 2011 at 08:03:35AM +0200, Jean Delvare wrote:
> On Mon, 11 Jul 2011 14:52:21 +0900, Paul Mundt wrote:
> > On Fri, Jul 01, 2011 at 10:00:42AM +0900, Yoshihiro Shimoda wrote:
> > > This driver supports the RIIC module. The SH7757 has it.
> > > The driver doesn't use any IRQ handler.
> > > 
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  drivers/i2c/busses/Kconfig    |    9 +
> > >  drivers/i2c/busses/Makefile   |    1 +
> > >  drivers/i2c/busses/i2c-riic.c |  589 +++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/i2c/riic.h      |   29 ++
> > >  4 files changed, 628 insertions(+), 0 deletions(-)
> > >  create mode 100644 drivers/i2c/busses/i2c-riic.c
> > >  create mode 100644 include/linux/i2c/riic.h
> > > 
> > Ping?
> 
> Embedded platform -> ping Ben, not me.
> 
It was addressed to Ben and there has been no response. Ben has also been
included in the Cc for the ping in question. If there continues to be no
response, how exactly do you propose making progress on this?
