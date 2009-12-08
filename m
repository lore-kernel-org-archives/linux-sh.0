From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 08 Dec 2009 00:58:02 +0000
Subject: Re: [PATCH 3/5] sh: fix DMA driver's descriptor chaining and cookie
Message-Id: <e9c3a7c20912071658n6ccf5a44pf0bb028adbe3f0a4@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
	 <Pine.LNX.4.64.0912041941290.3981@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912041941290.3981@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

I would like an acked-by from Nobuhiro  on this one.

[ full patch quoted below ]

Thanks,
Dan

On Fri, Dec 4, 2009 at 11:44 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> The SH DMA driver wrongly assigns negative cookies to transfer descriptor=
s,
> also, its chaining of partial descriptors is broken. The latter problem is
> usually invisible, because maximum transfer size per chunk is 16M, but if=
 you
> artificially set this limit lower, the driver fails. Since cookies are al=
so
> used in chunk management, both these problems are fixed in one patch.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0drivers/dma/shdma.c | =A0246 ++++++++++++++++++++++++++++++++---------=
----------
> =A0drivers/dma/shdma.h | =A0 =A01 -
> =A02 files changed, 153 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
> index f5fae12..aac8f78 100644
> --- a/drivers/dma/shdma.c
> +++ b/drivers/dma/shdma.c
> @@ -30,9 +30,12 @@
> =A0#include "shdma.h"
>
> =A0/* DMA descriptor control */
> -#define DESC_LAST =A0 =A0 =A0(-1)
> -#define DESC_COMP =A0 =A0 =A0(1)
> -#define DESC_NCOMP =A0 =A0 (0)
> +enum sh_dmae_desc_status {
> + =A0 =A0 =A0 DESC_PREPARED,
> + =A0 =A0 =A0 DESC_SUBMITTED,
> + =A0 =A0 =A0 DESC_COMPLETED, /* completed, have to call callback */
> + =A0 =A0 =A0 DESC_WAITING, =A0 /* callback called, waiting for ack / re-=
submit */
> +};
>
> =A0#define NR_DESCS_PER_CHANNEL 32
> =A0/*
> @@ -45,6 +48,8 @@
> =A0*/
> =A0#define RS_DEFAULT =A0(RS_DUAL)
>
> +static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool a=
ll);
> +
> =A0#define SH_DMAC_CHAN_BASE(id) (dma_base_addr[id])
> =A0static void sh_dmae_writel(struct sh_dmae_chan *sh_dc, u32 data, u32 r=
eg)
> =A0{
> @@ -185,7 +190,7 @@ static int dmae_set_dmars(struct sh_dmae_chan *sh_cha=
n, u16 val)
>
> =A0static dma_cookie_t sh_dmae_tx_submit(struct dma_async_tx_descriptor *=
tx)
> =A0{
> - =A0 =A0 =A0 struct sh_desc *desc =3D tx_to_sh_desc(tx);
> + =A0 =A0 =A0 struct sh_desc *desc =3D tx_to_sh_desc(tx), *chunk;
> =A0 =A0 =A0 =A0struct sh_dmae_chan *sh_chan =3D to_sh_chan(tx->chan);
> =A0 =A0 =A0 =A0dma_cookie_t cookie;
>
> @@ -196,45 +201,40 @@ static dma_cookie_t sh_dmae_tx_submit(struct dma_as=
ync_tx_descriptor *tx)
> =A0 =A0 =A0 =A0if (cookie < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cookie =3D 1;
>
> - =A0 =A0 =A0 /* If desc only in the case of 1 */
> - =A0 =A0 =A0 if (desc->async_tx.cookie !=3D -EBUSY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->async_tx.cookie =3D cookie;
> - =A0 =A0 =A0 sh_chan->common.cookie =3D desc->async_tx.cookie;
> -
> - =A0 =A0 =A0 list_splice_init(&desc->tx_list, sh_chan->ld_queue.prev);
> + =A0 =A0 =A0 tx->cookie =3D cookie;
> + =A0 =A0 =A0 dev_dbg(sh_chan->dev, "submit %p #%d start %u\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx, tx->cookie, desc->hw.sar);
> + =A0 =A0 =A0 sh_chan->common.cookie =3D tx->cookie;
> +
> + =A0 =A0 =A0 /* Mark all chunks of this descriptor as submitted */
> + =A0 =A0 =A0 list_for_each_entry(chunk, desc->node.prev, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* All chunks are on the global ld_queue,=
 so, we have to find
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the end of the chain ourselves
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chunk !=3D desc && (chunk->async_tx.coo=
kie > 0 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 chunk->async_tx.cookie =3D -EBUSY))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chunk->mark =3D DESC_SUBMITTED;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0spin_unlock_bh(&sh_chan->desc_lock);
>
> =A0 =A0 =A0 =A0return cookie;
> =A0}
>
> +/* Called with desc_lock held */
> =A0static struct sh_desc *sh_dmae_get_desc(struct sh_dmae_chan *sh_chan)
> =A0{
> - =A0 =A0 =A0 struct sh_desc *desc, *_desc, *ret =3D NULL;
> -
> - =A0 =A0 =A0 spin_lock_bh(&sh_chan->desc_lock);
> - =A0 =A0 =A0 list_for_each_entry_safe(desc, _desc, &sh_chan->ld_free, no=
de) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (async_tx_test_ack(&desc->async_tx)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&desc->node);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D desc;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 spin_unlock_bh(&sh_chan->desc_lock);
> -
> - =A0 =A0 =A0 return ret;
> -}
> + =A0 =A0 =A0 struct sh_desc *desc;
>
> -static void sh_dmae_put_desc(struct sh_dmae_chan *sh_chan, struct sh_des=
c *desc)
> -{
> - =A0 =A0 =A0 if (desc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_bh(&sh_chan->desc_lock);
> + =A0 =A0 =A0 if (list_empty(&sh_chan->ld_free))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_splice_init(&desc->tx_list, &sh_chan->=
ld_free);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&desc->node, &sh_chan->ld_free);
> + =A0 =A0 =A0 desc =3D list_entry(sh_chan->ld_free.next, struct sh_desc, =
node);
> + =A0 =A0 =A0 list_del(&desc->node);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_bh(&sh_chan->desc_lock);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 return desc;
> =A0}
>
> =A0static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
> @@ -254,10 +254,9 @@ static int sh_dmae_alloc_chan_resources(struct dma_c=
han *chan)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&sh_chan->common);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->async_tx.tx_submit =3D sh_dmae_tx_su=
bmit;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->async_tx.flags =3D DMA_CTRL_ACK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&desc->tx_list);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sh_dmae_put_desc(sh_chan, desc);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_bh(&sh_chan->desc_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&desc->node, &sh_chan->ld_free);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sh_chan->descs_allocated++;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0spin_unlock_bh(&sh_chan->desc_lock);
> @@ -274,7 +273,10 @@ static void sh_dmae_free_chan_resources(struct dma_c=
han *chan)
> =A0 =A0 =A0 =A0struct sh_desc *desc, *_desc;
> =A0 =A0 =A0 =A0LIST_HEAD(list);
>
> - =A0 =A0 =A0 BUG_ON(!list_empty(&sh_chan->ld_queue));
> + =A0 =A0 =A0 /* Prepared and not submitted descriptors can still be on t=
he queue */
> + =A0 =A0 =A0 if (!list_empty(&sh_chan->ld_queue))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sh_dmae_chan_ld_cleanup(sh_chan, true);
> +
> =A0 =A0 =A0 =A0spin_lock_bh(&sh_chan->desc_lock);
>
> =A0 =A0 =A0 =A0list_splice_init(&sh_chan->ld_free, &list);
> @@ -293,6 +295,7 @@ static struct dma_async_tx_descriptor *sh_dmae_prep_m=
emcpy(
> =A0 =A0 =A0 =A0struct sh_dmae_chan *sh_chan;
> =A0 =A0 =A0 =A0struct sh_desc *first =3D NULL, *prev =3D NULL, *new;
> =A0 =A0 =A0 =A0size_t copy_size;
> + =A0 =A0 =A0 LIST_HEAD(tx_list);
>
> =A0 =A0 =A0 =A0if (!chan)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> @@ -302,43 +305,70 @@ static struct dma_async_tx_descriptor *sh_dmae_prep=
_memcpy(
>
> =A0 =A0 =A0 =A0sh_chan =3D to_sh_chan(chan);
>
> + =A0 =A0 =A0 /* Have to lock the whole loop to protect against concurren=
t release */
> + =A0 =A0 =A0 spin_lock_bh(&sh_chan->desc_lock);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Chaining:
> + =A0 =A0 =A0 =A0* first descriptor is what user is dealing with in all A=
PI calls, its
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0cookie is at first set to -EBUSY, at tx-sub=
mit to a positive
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0number
> + =A0 =A0 =A0 =A0* if more than one chunk is needed further chunks have c=
ookie =3D -EINVAL
> + =A0 =A0 =A0 =A0* the last chunk, if not equal to the first, has cookie =
=3D -ENOSPC
> + =A0 =A0 =A0 =A0* all chunks are linked onto the tx_list head with their=
 .node heads
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0only during this function, then they are im=
mediately spliced
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0onto the queue
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Allocate the link descriptor from DMA p=
ool */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new =3D sh_dmae_get_desc(sh_chan);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!new) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(sh_chan->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0"No free memory for link descriptor\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_get_desc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_splice(&tx_list, &sh_c=
han->ld_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_bh(&sh_chan->de=
sc_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 copy_size =3D min(len, (size_t)SH_DMA_TCR_M=
AX);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 copy_size =3D min(len, (size_t)SH_DMA_TCR_M=
AX + 1);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new->hw.sar =3D dma_src;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new->hw.dar =3D dma_dest;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new->hw.tcr =3D copy_size;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!first)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!first) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* First desc */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new->async_tx.cookie =3D -E=
BUSY;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0first =3D new;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Other desc - invisible t=
o the user */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new->async_tx.cookie =3D -E=
INVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sh_chan->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "chaining %u of %u with %p,=
 start %u, cookie %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 copy_size, len, &new->async=
_tx, dma_src,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new->async_tx.cookie);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 new->mark =3D DESC_NCOMP;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 async_tx_ack(&new->async_tx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new->mark =3D DESC_PREPARED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new->async_tx.flags =3D flags;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prev =3D new;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len -=3D copy_size;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_src +=3D copy_size;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_dest +=3D copy_size;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Insert the link descriptor to the LD ri=
ng */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&new->node, &first->tx_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&new->node, &tx_list);
> =A0 =A0 =A0 =A0} while (len);
>
> - =A0 =A0 =A0 new->async_tx.flags =3D flags; /* client is in control of t=
his ack */
> - =A0 =A0 =A0 new->async_tx.cookie =3D -EBUSY; /* Last desc */
> + =A0 =A0 =A0 if (new !=3D first)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new->async_tx.cookie =3D -ENOSPC;
>
> - =A0 =A0 =A0 return &first->async_tx;
> + =A0 =A0 =A0 /* Put them immediately on the queue, so, they don't get lo=
st */
> + =A0 =A0 =A0 list_splice_tail(&tx_list, sh_chan->ld_queue.prev);
>
> -err_get_desc:
> - =A0 =A0 =A0 sh_dmae_put_desc(sh_chan, first);
> - =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 spin_unlock_bh(&sh_chan->desc_lock);
>
> + =A0 =A0 =A0 return &first->async_tx;
> =A0}
>
> =A0/*
> @@ -346,64 +376,87 @@ err_get_desc:
> =A0*
> =A0* This function clean up the ld_queue of DMA channel.
> =A0*/
> -static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan)
> +static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool a=
ll)
> =A0{
> =A0 =A0 =A0 =A0struct sh_desc *desc, *_desc;
>
> =A0 =A0 =A0 =A0spin_lock_bh(&sh_chan->desc_lock);
> =A0 =A0 =A0 =A0list_for_each_entry_safe(desc, _desc, &sh_chan->ld_queue, =
node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_async_tx_callback callback;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *callback_param;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dma_async_tx_descriptor *tx =3D &des=
c->async_tx;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* non send data */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc->mark =3D DESC_NCOMP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* unsent data */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc->mark =3D DESC_SUBMITTED && !all)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* send data sesc */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 callback =3D desc->async_tx.callback;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 callback_param =3D desc->async_tx.callback_=
param;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc->mark =3D DESC_PREPARED && !all)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Call callback on the "exposed" descripto=
r (cookie > 0) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tx->cookie > 0 && (desc->mark =3D DESC_=
COMPLETED ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0desc->mark =3D DESC_WAITING)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sh_desc *chunk;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool head_acked =3D async_t=
x_test_ack(tx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* sent data desc */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_async_tx_callback callb=
ack =3D tx->callback;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Run the link descriptor =
callback function */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (callback && desc->mark =
=3D DESC_COMPLETED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock=
_bh(&sh_chan->desc_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sh_=
chan->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "descriptor %p callback\n", tx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 callback(tx=
->callback_param);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_b=
h(&sh_chan->desc_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Remove from ld_queue list */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_splice_init(&desc->tx_list, &sh_chan->=
ld_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(chunk, =
desc->node.prev, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* All ch=
unks are on the global ld_queue, so, we
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* have t=
o find the end of the chain ourselves
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chunk !=
=3D desc &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ch=
unk->async_tx.cookie > 0 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
chunk->async_tx.cookie =3D -EBUSY))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (head_ac=
ked)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 async_tx_ack(&chunk->async_tx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 chunk->mark =3D DESC_WAITING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sh_chan->dev, "link descriptor %p w=
ill be recycle.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sh_chan->dev, "descriptor %p #%d co=
mpleted.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx, tx->cookie);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_move(&desc->node, &sh_chan->ld_free);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Run the link descriptor callback functio=
n */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (callback) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_bh(&sh_chan->de=
sc_lock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sh_chan->dev, "link=
 descriptor %p callback\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 desc);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 callback(callback_param);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_bh(&sh_chan->desc=
_lock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (((desc->mark =3D DESC_COMPLETED ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->mark =3D DESC_WAITING) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0async_tx_test_ack(&desc->async_t=
x)) || all)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Remove from ld_queue lis=
t */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_move(&desc->node, &sh_=
chan->ld_free);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0spin_unlock_bh(&sh_chan->desc_lock);
> =A0}
>
> =A0static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan)
> =A0{
> - =A0 =A0 =A0 struct list_head *ld_node;
> =A0 =A0 =A0 =A0struct sh_dmae_regs hw;
> + =A0 =A0 =A0 struct sh_desc *sd;
>
> =A0 =A0 =A0 =A0/* DMA work check */
> =A0 =A0 =A0 =A0if (dmae_is_idle(sh_chan))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> + =A0 =A0 =A0 spin_lock_bh(&sh_chan->desc_lock);
> =A0 =A0 =A0 =A0/* Find the first un-transfer desciptor */
> - =A0 =A0 =A0 for (ld_node =3D sh_chan->ld_queue.next;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ld_node !=3D &sh_chan->ld_queue)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (to_sh_desc(ld_node)->ma=
rk =3D DESC_COMP);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ld_node =3D ld_node->next)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> -
> - =A0 =A0 =A0 if (ld_node !=3D &sh_chan->ld_queue) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get the ld start address from ld_queue */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw =3D to_sh_desc(ld_node)->hw;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmae_set_reg(sh_chan, hw);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmae_start(sh_chan);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 list_for_each_entry(sd, &sh_chan->ld_queue, node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sd->mark =3D DESC_SUBMITTED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get the ld start address=
 from ld_queue */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw =3D sd->hw;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmae_set_reg(sh_chan, hw);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmae_start(sh_chan);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_bh(&sh_chan->desc_lock);
> =A0}
>
> =A0static void sh_dmae_memcpy_issue_pending(struct dma_chan *chan)
> @@ -421,12 +474,11 @@ static enum dma_status sh_dmae_is_complete(struct d=
ma_chan *chan,
> =A0 =A0 =A0 =A0dma_cookie_t last_used;
> =A0 =A0 =A0 =A0dma_cookie_t last_complete;
>
> - =A0 =A0 =A0 sh_dmae_chan_ld_cleanup(sh_chan);
> + =A0 =A0 =A0 sh_dmae_chan_ld_cleanup(sh_chan, false);
>
> =A0 =A0 =A0 =A0last_used =3D chan->cookie;
> =A0 =A0 =A0 =A0last_complete =3D sh_chan->completed_cookie;
> - =A0 =A0 =A0 if (last_complete =3D -EBUSY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_complete =3D last_used;
> + =A0 =A0 =A0 BUG_ON(last_complete < 0);
>
> =A0 =A0 =A0 =A0if (done)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*done =3D last_complete;
> @@ -481,11 +533,13 @@ static irqreturn_t sh_dmae_err(int irq, void *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D sh_dmae_rst(0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> +#ifdef SH_DMAC_BASE1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (shdev->pdata.mode & SHDMA_DMAOR1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D sh_dmae_rst(1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_irq(irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0 =A0 =A0 =A0}
> @@ -499,30 +553,36 @@ static void dmae_do_tasklet(unsigned long data)
> =A0 =A0 =A0 =A0u32 sar_buf =3D sh_dmae_readl(sh_chan, SAR);
> =A0 =A0 =A0 =A0list_for_each_entry_safe(desc, _desc,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&sh_chan->ld_queue, node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((desc->hw.sar + desc->hw.tcr) =3D sar_b=
uf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((desc->hw.sar + desc->hw.tcr) =3D sar_b=
uf &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->mark =3D DESC_SUBMITTED) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cur_desc =3D desc;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (cur_desc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sh_chan->dev, "done %p #%d start %u=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &cur_desc->async_tx, cur_de=
sc->async_tx.cookie,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_desc->hw.sar);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (cur_desc->async_tx.cookie) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0: /* other desc data */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case -EINVAL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case -ENOSPC:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* other desc data */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case -EBUSY: /* last desc */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sh_chan->completed_cookie > - =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_desc->async_tx.cookie;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case -EBUSY: /* Cannot be */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 default: /* first desc ( 0 < )*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default: /* first desc: cookie > 0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sh_chan->completed_cookie =
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_desc->a=
sync_tx.cookie - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_desc->a=
sync_tx.cookie;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_desc->mark =3D DESC_COMP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_desc->mark =3D DESC_COMPLETED;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/* Next desc */
> =A0 =A0 =A0 =A0sh_chan_xfer_ld_queue(sh_chan);
> - =A0 =A0 =A0 sh_dmae_chan_ld_cleanup(sh_chan);
> + =A0 =A0 =A0 sh_dmae_chan_ld_cleanup(sh_chan, false);
> =A0}
>
> =A0static unsigned int get_dmae_irq(unsigned int id)
> diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
> index 2b4bc15..c93555c 100644
> --- a/drivers/dma/shdma.h
> +++ b/drivers/dma/shdma.h
> @@ -26,7 +26,6 @@ struct sh_dmae_regs {
> =A0};
>
> =A0struct sh_desc {
> - =A0 =A0 =A0 struct list_head tx_list;
> =A0 =A0 =A0 =A0struct sh_dmae_regs hw;
> =A0 =A0 =A0 =A0struct list_head node;
> =A0 =A0 =A0 =A0struct dma_async_tx_descriptor async_tx;
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
