From: Bastian Hecht <hechtb@googlemail.com>
Date: Mon, 23 Apr 2012 08:41:45 +0000
Subject: Re: [PATCH 1/9] mtd: sh_flctl: Add support for error IRQ
Message-Id: <CABYn4syas_6QsL+A3Vw32_AsL2oQRCFDrvY+=dJdnM5ouTDkmA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
 <1334913230-23615-2-git-send-email-hechtb@gmail.com>
 <1563935.g1Nah5i3Kc@avalon>
In-Reply-To: <1563935.g1Nah5i3Kc@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hello Laurent,

2012/4/21 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Bastian,
>
> Thanks for the patch.

Thanks for the reviews. Let me know if you could need my help too.

> On Friday 20 April 2012 11:13:42 Bastian Hecht wrote:
>> When the data transfer between the controller and the NAND chip fails,
>> we now get notified.
>>
>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>> ---
>> =A0drivers/mtd/nand/sh_flctl.c =A0| =A0 31 +++++++++++++++++++++++++++++=
--
>> =A0include/linux/mtd/sh_flctl.h | =A0 =A07 +++++++
>> =A02 files changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
>> index 2ee9a1b..3c27921 100644
>> --- a/drivers/mtd/nand/sh_flctl.c
>> +++ b/drivers/mtd/nand/sh_flctl.c
>> @@ -24,6 +24,7 @@
>> =A0#include <linux/module.h>
>> =A0#include <linux/kernel.h>
>> =A0#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> =A0#include <linux/io.h>
>> =A0#include <linux/platform_device.h>
>> =A0#include <linux/pm_runtime.h>
>> @@ -69,7 +70,7 @@ static struct nand_bbt_descr flctl_4secc_largepage =3D=
 {
>> =A0static void empty_fifo(struct sh_flctl *flctl)
>> =A0{
>> =A0 =A0 =A0 writel(0x000c0000, FLINTDMACR(flctl)); =A0/* FIFO Clear */
>
> Shouldn't this write flctl->flintdmacr_base | 0x000c0000 ? If you change =
this
> line, you could also define and use the AC1CLR and AC0CLR bits.

True, it should be better not to toggle the other settings.

>> - =A0 =A0 writel(0x00000000, FLINTDMACR(flctl)); =A0/* Clear Error flags=
 */
>> + =A0 =A0 writel(flctl->flintdmacr_base, FLINTDMACR(flctl));
>> =A0}
>>
>> =A0static void start_translation(struct sh_flctl *flctl)
>> @@ -838,6 +839,14 @@ static int flctl_chip_init_tail(struct mtd_info *mt=
d)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static irqreturn_t flctl_handle_flste(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct sh_flctl *flctl =3D dev_id;
>> + =A0 =A0 dev_err(&flctl->pdev->dev, "flste irq: %x\n", readl(FLINTDMACR=
(flctl)));
>> +
>
> You should clear the interrupt flags here, otherwise endless interrupts w=
ill
> occur. I suppose this will be fixed in a later patch, but it's a good pra=
ctice
> to avoid breaking git bisect.

Oh yes! Thanks for the hint.

>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> =A0static int __devinit flctl_probe(struct platform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 struct resource *res;
>> @@ -846,6 +855,7 @@ static int __devinit flctl_probe(struct platform_dev=
ice
>> *pdev) struct nand_chip *nand;
>> =A0 =A0 =A0 struct sh_flctl_platform_data *pdata;
>> =A0 =A0 =A0 int ret =3D -ENXIO;
>> + =A0 =A0 int irq;
>>
>> =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
>> =A0 =A0 =A0 if (pdata =3D NULL) {
>> @@ -871,14 +881,27 @@ static int __devinit flctl_probe(struct
>> platform_device *pdev) goto err_iomap;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 irq =3D platform_get_irq(pdev, 0);
>> + =A0 =A0 if (irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get flste irq d=
ata\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_flste;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D request_irq(irq, flctl_handle_flste, IRQF_SHARED, "fls=
te", flctl);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "request interrupt failed.=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_flste;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 platform_set_drvdata(pdev, flctl);
>> =A0 =A0 =A0 flctl_mtd =3D &flctl->mtd;
>> =A0 =A0 =A0 nand =3D &flctl->chip;
>> =A0 =A0 =A0 flctl_mtd->priv =3D nand;
>> =A0 =A0 =A0 flctl->pdev =3D pdev;
>> - =A0 =A0 flctl->flcmncr_base =3D pdata->flcmncr_val;
>> =A0 =A0 =A0 flctl->hwecc =3D pdata->has_hwecc;
>> =A0 =A0 =A0 flctl->holden =3D pdata->use_holden;
>> + =A0 =A0 flctl->flcmncr_base =3D pdata->flcmncr_val;
>> + =A0 =A0 flctl->flintdmacr_base =3D flctl->hwecc ? (STERINTE | ECERB) :=
 STERINTE;
>>
>> =A0 =A0 =A0 nand->options =3D NAND_NO_AUTOINCR;
>>
>> @@ -919,6 +942,9 @@ static int __devinit flctl_probe(struct platform_dev=
ice
>> *pdev)
>>
>> =A0err_chip:
>> =A0 =A0 =A0 pm_runtime_disable(&pdev->dev);
>> + =A0 =A0 free_irq(platform_get_irq(pdev, 0), flctl);
>> +err_flste:
>> + =A0 =A0 iounmap(flctl->reg);
>
> The missing iounmap() is a separate issue, you should split it to its own
> patch. It's also seems to be missing in flctl_remove() btw.

Ok I see. I've added an additional patch.

Best regards,

 Bastian Hecht

>> =A0err_iomap:
>> =A0 =A0 =A0 kfree(flctl);
>> =A0 =A0 =A0 return ret;
>> @@ -930,6 +956,7 @@ static int __devexit flctl_remove(struct platform_de=
vice
>> *pdev)
>>
>> =A0 =A0 =A0 nand_release(&flctl->mtd);
>> =A0 =A0 =A0 pm_runtime_disable(&pdev->dev);
>> + =A0 =A0 free_irq(platform_get_irq(pdev, 0), flctl);
>> =A0 =A0 =A0 kfree(flctl);
>>
>> =A0 =A0 =A0 return 0;
>> diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
>> index a38e1fa..6832a90 100644
>> --- a/include/linux/mtd/sh_flctl.h
>> +++ b/include/linux/mtd/sh_flctl.h
>> @@ -107,6 +107,12 @@
>> =A0#define DOCMD2_E =A0 =A0 (0x1 << 17) =A0 =A0 /* 2nd cmd stage execute=
 */
>> =A0#define DOCMD1_E =A0 =A0 (0x1 << 16) =A0 =A0 /* 1st cmd stage execute=
 */
>>
>> +/* FLINTDMACR control bits */
>> +#define ESTERINTE =A0 =A0(0x1 << 24) =A0 =A0 /* ECC error interrupt ena=
ble */
>> +#define ECERB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 9) =A0 =A0 =A0/* E=
CC error */
>> +#define STERB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 8) =A0 =A0 =A0/* S=
tatus error */
>> +#define STERINTE =A0 =A0 (0x1 << 4) =A0 =A0 =A0/* Status error enable */
>> +
>> =A0/* FLTRCR control bits */
>> =A0#define TRSTRT =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << 0) =A0 =A0 =A0/* t=
ranslation start */
>> =A0#define TREND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 1) =A0 =A0 =A0/*=
 translation end */
>> @@ -145,6 +151,7 @@ struct sh_flctl {
>> =A0 =A0 =A0 uint32_t erase_ADRCNT; =A0 =A0 =A0 =A0 =A0/* bits of FLCMDCR=
 in ERASE1 cmd */
>> =A0 =A0 =A0 uint32_t rw_ADRCNT; =A0 =A0 /* bits of FLCMDCR in READ WRITE=
 cmd */
>> =A0 =A0 =A0 uint32_t flcmncr_base; =A0/* base value of FLCMNCR */
>> + =A0 =A0 uint32_t flintdmacr_base; =A0 =A0 =A0 /* irq enable bits */
>>
>> =A0 =A0 =A0 int =A0 =A0 hwecc_cant_correct[4];
> --
> Regards,
>
> Laurent Pinchart
>
