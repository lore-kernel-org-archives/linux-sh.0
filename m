From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Aug 2011 08:16:03 +0000
Subject: Re: [PATCH] serial: sh-sci: don't filter on DMA device, use only
Message-Id: <CANqRtoRn-Csu+Rns6dn6=cJmRqbZfLKXA9brs8Ug9rFvGRn78w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1106241354060.6014@axis700.grange>
	<1308916071.1536.4.camel@vkoul-udesk3>
	<20110829080047.GJ31809@linux-sh.org>
In-Reply-To: <20110829080047.GJ31809@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Magnus Damm <damm@opensource.se>

On Mon, Aug 29, 2011 at 5:00 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Fri, Jun 24, 2011 at 05:17:51PM +0530, Koul, Vinod wrote:
>> On Fri, 2011-06-24 at 13:56 +0200, Guennadi Liakhovetski wrote:
>> > On some sh-mobile systems there are more than one DMA controllers, that
>> > can be used for serial ports. Specifying a DMA device in sh-sci platfo=
rm
>> > data unnecessarily restricts the driver to only use one DMA controller.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> > ---
>> > =A0drivers/tty/serial/sh-sci.c | =A0 25 ++++++++-----------------
>> > =A0include/linux/serial_sci.h =A0| =A0 =A02 --
>> > =A02 files changed, 8 insertions(+), 19 deletions(-)
>> >
>> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> > index ebd8629..8711f4e 100644
>> > --- a/drivers/tty/serial/sh-sci.c
>> > +++ b/drivers/tty/serial/sh-sci.c
>> > @@ -1295,12 +1295,8 @@ static bool filter(struct dma_chan *chan, void =
*slave)
>> > =A0 =A0 dev_dbg(chan->device->dev, "%s: slave ID %d\n", __func__,
>> > =A0 =A0 =A0 =A0 =A0 =A0 param->slave_id);
>> >
>> > - =A0 if (param->dma_dev =3D chan->device->dev) {
>> > - =A0 =A0 =A0 =A0 =A0 chan->private =3D param;
>> > - =A0 =A0 =A0 =A0 =A0 return true;
>> > - =A0 } else {
>> > - =A0 =A0 =A0 =A0 =A0 return false;
>> > - =A0 }
>> > + =A0 chan->private =3D param;
>> > + =A0 return true;
>> You should not assign chan->private.
>> Please move this =A0to dma_slave_control API
>
> I haven't seen any reply to this comment and this patch seems to still be
> outstanding, is there an updated version of this patch that I've missed?

This patch is simply making the SCIF driver behave as other drivers
that support DMA Engine like for instance:
MMCIF - drivers/mmc/host/sh_mmcif.c
SDHI - drivers/mmc/host/tmio_mmc_dma.c
USBHS - drivers/usb/renesas_usbhs/fifo.c

The SIU driver is still acting like the SCIF driver though:
SIU - sound/soc/sh/siu_pcm.c

If possible I would prefer if the drivers for the SCIF and the SIU
first could be cleaned up to behave like MMCIF/SDHI/USBHS and then we
can move to make use of the dma_slave_control API after that.

Any thoughs?

Thanks,

/ magnus
