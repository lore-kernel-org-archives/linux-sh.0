From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 16 Nov 2015 07:13:37 +0000
Subject: RE: [PATCH] dmaengine: usb-dmac: fix endless loop in usb_dmac_chan_terminate_all()
Message-Id: <SG2PR06MB09197CDE1D537FC045707051D81E0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447303060-7880-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1447303060-7880-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Vinod,

> From: Vinod Koul [mailto:vinod.koul@intel.com]
> Sent: Monday, November 16, 2015 12:47 PM
>=20
> On Thu, Nov 12, 2015 at 01:37:40PM +0900, Yoshihiro Shimoda wrote:
> > This patch fixes an issue that list_for_each_entry() in
> > usb_dmac_chan_terminate_all() is possible to cause endless loop because
> > this will move own desc to the desc_freed. So, this driver should use
> > list_for_each_entry_safe() instead of list_for_each_entry().
>=20
> Sorry this is not clear to my why this owuld have endless loop, can you
> explain more

This issue will happens if &uchan->desc_got has one or more lists.
(In other words, there was a potential problem from the first commit of thi=
s driver...)

This is because that this driver use "desc" for list_move_tail() as the fir=
st
argument, and the list_move_tail() calls __list_del_entry(). So, the desc m=
ay be
wrong list_head for list_next_entry().

static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
{
<snip>
  	list_splice_init(&uchan->desc_got, &list);
	list_for_each_entry(desc, &list, node)
  		list_move_tail(&desc->node, &uchan->desc_freed);

< in include/linux/list.h >
static inline void list_move_tail(struct list_head *list,
                                  struct list_head *head)
{
        __list_del_entry(list);
        list_add_tail(list, head);
}

If I enabled CONFIG_DEBUG_LIST, the following WARNING happened:
------------[ cut here ]------------
WARNING: CPU: 2 PID: 2477 at lib/list_debug.c:33 __list_add+0x64/0xb0()
list_add corruption. prev->next should be next (edca6098), but was ee936e00=
. (prev=EE936ec0).
Modules linked in: g_mass_storage(-) usb_f_mass_storage libcomposite
CPU: 2 PID: 2477 Comm: file-storage Not tainted 4.3.0-rc1-00002-g4d15d22 #27
Hardware name: Generic R8A7790 (Flattened Device Tree)
Backtrace:
[<c00137a0>] (dump_backtrace) from [<c0013998>] (show_stack+0x18/0x1c)
 r7:c05d2664 r6:ee92e140 r5:00000009 r4:00000000
[<c0013980>] (show_stack) from [<c01be7d0>] (dump_stack+0x78/0x94)
[<c01be758>] (dump_stack) from [<c0025224>] (warn_slowpath_common+0x8c/0xb8)
 r5:00000009 r4:ee22bd90
[<c0025198>] (warn_slowpath_common) from [<c0025288>] (warn_slowpath_fmt+0x=
38/0x40)
 r9:edca6098 r8:a0000093 r7:edca605c r6:edca6098 r5:edca6098 r4:ee936ec0
[<c0025254>] (warn_slowpath_fmt) from [<c01d49b8>] (__list_add+0x64/0xb0)
 r3:edca6098 r2:c05d2675
[<c01d4954>] (__list_add) from [<c0202e5c>] (usb_dmac_chan_terminate_all+0x=
14c/0x17c)
 r6:ee22bde0 r5:edca6058 r4:edca6010
[<c0202d10>] (usb_dmac_chan_terminate_all) from [<c02e84b0>] (usbhs_pkt_pop=
+0xa0/0xf4)
< snip >

Best regards,
Yoshihiro Shimoda

> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/dma/sh/usb-dmac.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> > index ebd8a5f..16fb330 100644
> > --- a/drivers/dma/sh/usb-dmac.c
> > +++ b/drivers/dma/sh/usb-dmac.c
> > @@ -448,7 +448,7 @@ usb_dmac_prep_slave_sg(struct dma_chan *chan, struc=
t scatterlist *sgl,
> >  static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
> >  {
> >  	struct usb_dmac_chan *uchan =3D to_usb_dmac_chan(chan);
> > -	struct usb_dmac_desc *desc;
> > +	struct usb_dmac_desc *desc, *_desc;
> >  	unsigned long flags;
> >  	LIST_HEAD(head);
> >  	LIST_HEAD(list);
> > @@ -459,7 +459,7 @@ static int usb_dmac_chan_terminate_all(struct dma_c=
han *chan)
> >  	if (uchan->desc)
> >  		uchan->desc =3D NULL;
> >  	list_splice_init(&uchan->desc_got, &list);
> > -	list_for_each_entry(desc, &list, node)
> > +	list_for_each_entry_safe(desc, _desc, &list, node)
> >  		list_move_tail(&desc->node, &uchan->desc_freed);
> >  	spin_unlock_irqrestore(&uchan->vc.lock, flags);
> >  	vchan_dma_desc_free_list(&uchan->vc, &head);
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> ~Vinod
