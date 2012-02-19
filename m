From: Bastian Hecht <hechtb@googlemail.com>
Date: Sun, 19 Feb 2012 10:48:41 +0000
Subject: Re: [PATCH v2 5/7] mtd: sh_flctl: Use cached register value for FLCMNCR
Message-Id: <CABYn4sz+a4wp-pfFvRhK=VMzxzQ9M1fXc73heXss+SN5o8rZew@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
 <1328960705-18699-6-git-send-email-hechtb@gmail.com>
 <2837466.z8bW9OK9D4@avalon>
In-Reply-To: <2837466.z8bW9OK9D4@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hello Laurent,

2012/2/18 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Bastian,
>
> Thanks for the patch.
>
> On Saturday 11 February 2012 12:45:03 Bastian Hecht wrote:
>> Instead of reading out the register, use a cached value. This will
>> make way for a proper runtime power management implementation.
>>
>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>> ---
>> changelog: I delayed the rtpm patch until the clock code is fixed for
>> board mackerel, so that no "udelay(1);" is needed. Instead I cleaned
>> up the code to use a cached register value. The rtpm code will benefit
>> from it.
>>
>> =A0drivers/mtd/nand/sh_flctl.c =A0| =A0 15 +++------------
>> =A0include/linux/mtd/sh_flctl.h | =A0 =A01 +
>> =A02 files changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
>> index 5c3e71f..1af41fd 100644
>> --- a/drivers/mtd/nand/sh_flctl.c
>> +++ b/drivers/mtd/nand/sh_flctl.c
>> @@ -681,16 +681,13 @@ read_normal_exit:
>> =A0static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
>> =A0{
>> =A0 =A0 =A0 struct sh_flctl *flctl =3D mtd_to_flctl(mtd);
>> - =A0 =A0 uint32_t flcmncr_val =3D readl(FLCMNCR(flctl));
>>
>> =A0 =A0 =A0 switch (chipnr) {
>> =A0 =A0 =A0 case -1:
>> - =A0 =A0 =A0 =A0 =A0 =A0 flcmncr_val &=3D ~CE0_ENABLE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 writel(flcmncr_val, FLCMNCR(flctl));
>> + =A0 =A0 =A0 =A0 =A0 =A0 writel(flctl->flcmncr_val, FLCMNCR(flctl));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case 0:
>> - =A0 =A0 =A0 =A0 =A0 =A0 flcmncr_val |=3D CE0_ENABLE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 writel(flcmncr_val, FLCMNCR(flctl));
>> + =A0 =A0 =A0 =A0 =A0 =A0 writel(flctl->flcmncr_val | CE0_ENABLE, FLCMNC=
R(flctl));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>
> Shouldn't you use the cached value in set_cmd_regs() as well ?

Yes that's true. I agree that I should use it on all occasions.

>> @@ -748,11 +745,6 @@ static int flctl_verify_buf(struct mtd_info *mtd, c=
onst
>> u_char *buf, int len) return 0;
>> =A0}
>>
>> -static void flctl_register_init(struct sh_flctl *flctl, unsigned long v=
al)
>> -{
>> - =A0 =A0 writel(val, FLCMNCR(flctl));
>> -}
>> -
>> =A0static int flctl_chip_init_tail(struct mtd_info *mtd)
>> =A0{
>> =A0 =A0 =A0 struct sh_flctl *flctl =3D mtd_to_flctl(mtd);
>> @@ -851,10 +843,9 @@ static int __devinit flctl_probe(struct platform_de=
vice
>> *pdev) nand =3D &flctl->chip;
>> =A0 =A0 =A0 flctl_mtd->priv =3D nand;
>> =A0 =A0 =A0 flctl->pdev =3D pdev;
>> + =A0 =A0 flctl->flcmncr_val =3D pdata->flcmncr_val;
>> =A0 =A0 =A0 flctl->hwecc =3D pdata->has_hwecc;
>>
>> - =A0 =A0 flctl_register_init(flctl, pdata->flcmncr_val);
>> -
>> =A0 =A0 =A0 nand->options =3D NAND_NO_AUTOINCR;
>>
>> =A0 =A0 =A0 /* Set address of hardware control function */
>> diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
>> index e66c393..107fd8a 100644
>> --- a/include/linux/mtd/sh_flctl.h
>> +++ b/include/linux/mtd/sh_flctl.h
>> @@ -132,6 +132,7 @@ struct sh_flctl {
>> =A0 =A0 =A0 int =A0 =A0 erase1_page_addr; =A0 =A0 =A0 /* page_addr in ER=
ASE1 cmd */
>> =A0 =A0 =A0 uint32_t erase_ADRCNT; =A0 =A0 =A0 =A0 =A0/* bits of FLCMDCR=
 in ERASE1 cmd */
>> =A0 =A0 =A0 uint32_t rw_ADRCNT; =A0 =A0 /* bits of FLCMDCR in READ WRITE=
 cmd */
>> + =A0 =A0 uint32_t flcmncr_val; =A0 /* base value of FLCMNCR */
>>
>> =A0 =A0 =A0 int =A0 =A0 hwecc_cant_correct[4];
> --
> Regards,
>
> Laurent Pinchart

thanks,

 Bastian
