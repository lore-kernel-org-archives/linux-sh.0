From: Govindraj <govindraj.ti@gmail.com>
Date: Fri, 19 Feb 2010 09:59:56 +0000
Subject: Re: [PATCH 2/2] Add DMA support for the sh-sci.c serial driver
Message-Id: <d6a0f7aa1002190147u57a4d88g42b376eb8891e44d@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
	 <Pine.LNX.4.64.1002181726230.4373@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002181726230.4373@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-serial@vger.kernel.org

> +static void sci_request_dma(struct uart_port *port)
> +{
> + =A0 =A0 =A0 struct sci_port *s =3D to_sci_port(port);
> + =A0 =A0 =A0 struct sh_dmae_slave *param;
> + =A0 =A0 =A0 struct dma_chan *chan;
> + =A0 =A0 =A0 dma_cap_mask_t mask;
> + =A0 =A0 =A0 int nent;
> +
> + =A0 =A0 =A0 dev_dbg(port->dev, "%s: port %d DMA %p\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->line, s->dma_dev);
> +
> + =A0 =A0 =A0 if (!s->dma_dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 dma_cap_zero(mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);
> +
> + =A0 =A0 =A0 param =3D &s->param_tx;
> +
> + =A0 =A0 =A0 /* Slave ID, e.g., SHDMA_SLAVE_SCIF0_TX */
> + =A0 =A0 =A0 param->slave_id =3D s->slave_tx;
> + =A0 =A0 =A0 param->dma_dev =3D s->dma_dev;
> +
> + =A0 =A0 =A0 s->cookie_tx =3D -EINVAL;
> + =A0 =A0 =A0 chan =3D dma_request_channel(mask, filter, param);
> + =A0 =A0 =A0 dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, ch=
an);
> + =A0 =A0 =A0 if (chan) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->chan_tx =3D chan;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_init_table(&s->sg_tx, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* UART circular tx buffer is an aligned pa=
ge. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON((int)port->state->xmit.buf & ~PAGE_M=
ASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_set_page(&s->sg_tx, virt_to_page(port->s=
tate->xmit.buf),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART_XMIT_SIZE, (in=
t)port->state->xmit.buf & ~PAGE_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nent =3D dma_map_sg(port->dev, &s->sg_tx, 1=
, DMA_TO_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!nent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sci_tx_dma_release(s, false=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(port->dev, "%s: map=
ped %d@%p to %x\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_dma_len(=
&s->sg_tx),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->state=
->xmit.buf, sg_dma_address(&s->sg_tx));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->sg_len_tx =3D nent;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_WORK(&s->work_tx, work_fn_tx);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 param =3D &s->param_rx;
> +
> + =A0 =A0 =A0 /* Slave ID, e.g., SHDMA_SLAVE_SCIF0_RX */
> + =A0 =A0 =A0 param->slave_id =3D s->slave_rx;
> + =A0 =A0 =A0 param->dma_dev =3D s->dma_dev;
> +
> + =A0 =A0 =A0 chan =3D dma_request_channel(mask, filter, param);
> + =A0 =A0 =A0 dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, ch=
an);


If dma channel allocation fails how this scenario will be handled,
There is an possibility of dma_request_channel returning -EBUSY,


> + =A0 =A0 =A0 if (chan) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_addr_t dma[2];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *buf[2];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->chan_rx =3D chan;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->buf_len_rx =3D 2 * max(16, (int)port->fi=
fosize);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] =3D dma_alloc_coherent(port->dev, s-=
>buf_len_rx * 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 &dma[0], GFP_KERNEL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!buf[0]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(port->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed =
to allocate dma buffer, using PIO\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sci_rx_dma_release(s, true);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[1] =3D buf[0] + s->buf_len_rx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma[1] =3D dma[0] + s->buf_len_rx;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < 2; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct scatterlist *sg =3D =
&s->sg_rx[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_init_table(sg, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_set_page(sg, virt_to_pag=
e(buf[i]), s->buf_len_rx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (in=
t)buf[i] & ~PAGE_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg->dma_address =3D dma[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg->dma_length =3D sg->leng=
th;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_WORK(&s->work_rx, work_fn_rx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setup_timer(&s->rx_timer, rx_timer_fn, (uns=
igned long)s);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sci_submit_rx(s);
> + =A0 =A0 =A0 }
> +}


---
Regards,
Govindraj.R
