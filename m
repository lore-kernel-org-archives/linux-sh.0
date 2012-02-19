From: Bastian Hecht <hechtb@googlemail.com>
Date: Sun, 19 Feb 2012 11:04:08 +0000
Subject: Re: [PATCH v2 6/7] mtd: sh_flctl: Add FLHOLDCR register
Message-Id: <CABYn4syza6kL04SkWqgDYBp91hXJzLiAL2V6q+Dno6HDVzyQug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
 <1328960705-18699-7-git-send-email-hechtb@gmail.com>
 <2427717.Or3gUAU8Yx@avalon>
In-Reply-To: <2427717.Or3gUAU8Yx@avalon>
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
> On Saturday 11 February 2012 12:45:04 Bastian Hecht wrote:
>> Add a register used in new FLCTL hardware and a feature flag for it.
>>
>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>> ---
>> changelog: the write to the register has been moved due to patch 5.
>>
>> =A0drivers/mtd/nand/sh_flctl.c =A0| =A0 =A03 +++
>> =A0include/linux/mtd/sh_flctl.h | =A0 12 ++++++++++++
>> =A02 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
>> index 1af41fd..40dda26 100644
>> --- a/drivers/mtd/nand/sh_flctl.c
>> +++ b/drivers/mtd/nand/sh_flctl.c
>> @@ -688,6 +688,8 @@ static void flctl_select_chip(struct mtd_info *mtd, =
int
>> chipnr) break;
>> =A0 =A0 =A0 case 0:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(flctl->flcmncr_val | CE0_ENABLE, FLCM=
NCR(flctl));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (flctl->holden)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(HOLDEN, FLHOLDCR(flctl)=
);
>
> Can't this be done at probe time (maybe in flctl_chip_init_tail()) ? You =
could
> then get rid of the flctl->holden field and use platform data directly.

I need this information for runtime pm. I reworked this patch series
to be without rtpm, but from the next patch on (that's only waiting to
be posted), I'll want to have it like this.
In fact this is a design question:
I can either have a resume/runtime_resume callback whose only job is
to set FLHOLDCR. or I integrate this into select_chip. The first
variation saves 1 register write in case of no rtpm activated - the
second variation makes the code a bit slimmer.

What do you think?
1. Leave it like this and save the callbacks in the future
2. Rework it to be set at probe time() and postpone the design decision?
3. Rework it to be set at probe time() and implement callbacks in the
upcoming patches?

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> @@ -845,6 +847,7 @@ static int __devinit flctl_probe(struct platform_dev=
ice
>> *pdev) flctl->pdev =3D pdev;
>> =A0 =A0 =A0 flctl->flcmncr_val =3D pdata->flcmncr_val;
>> =A0 =A0 =A0 flctl->hwecc =3D pdata->has_hwecc;
>> + =A0 =A0 flctl->holden =3D pdata->use_holden;
>>
>> =A0 =A0 =A0 nand->options =3D NAND_NO_AUTOINCR;
>>
>> diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
>> index 107fd8a..6046443 100644
>> --- a/include/linux/mtd/sh_flctl.h
>> +++ b/include/linux/mtd/sh_flctl.h
>> @@ -38,6 +38,7 @@
>> =A0#define FLDTFIFO(f) =A0 =A0 =A0 =A0 =A0(f->reg + 0x24)
>> =A0#define FLECFIFO(f) =A0 =A0 =A0 =A0 =A0(f->reg + 0x28)
>> =A0#define FLTRCR(f) =A0 =A0 =A0 =A0 =A0 =A0(f->reg + 0x2C)
>> +#define FLHOLDCR(f) =A0 =A0 =A0 =A0 =A0(f->reg + 0x38)
>> =A0#define =A0 =A0 =A0FL4ECCRESULT0(f) =A0 =A0 =A0 =A0(f->reg + 0x80)
>> =A0#define =A0 =A0 =A0FL4ECCRESULT1(f) =A0 =A0 =A0 =A0(f->reg + 0x84)
>> =A0#define =A0 =A0 =A0FL4ECCRESULT2(f) =A0 =A0 =A0 =A0(f->reg + 0x88)
>> @@ -109,6 +110,15 @@
>> =A0#define TRSTRT =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << 0) =A0 =A0 =A0/* t=
ranslation start */
>> =A0#define TREND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 1) =A0 =A0 =A0/*=
 translation end */
>>
>> +/*
>> + * FLHOLDCR control bits
>> + *
>> + * HOLDEN: Bus Occupancy Enable (inverted)
>> + * Enable this bit when the external bus might be used in between
>> transfers. + * If not set and the bus gets used by other modules, a
>> deadlock occurs. + */
>> +#define HOLDEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << 0)
>> +
>> =A0/* FL4ECCCR control bits */
>> =A0#define =A0 =A0 =A0_4ECCFA =A0 =A0 =A0 =A0 (0x1 << 2) =A0 =A0 =A0/* 4=
 symbols correct fault */
>> =A0#define =A0 =A0 =A0_4ECCEND =A0 =A0 =A0 =A0(0x1 << 1) =A0 =A0 =A0/* 4=
 symbols end */
>> @@ -138,6 +148,7 @@ struct sh_flctl {
>>
>> =A0 =A0 =A0 unsigned page_size:1; =A0 /* NAND page size (0 =3D 512, 1 =
=3D 2048) */
>> =A0 =A0 =A0 unsigned hwecc:1; =A0 =A0 =A0 /* Hardware ECC (0 =3D disable=
d, 1 =3D enabled) */
>> + =A0 =A0 unsigned holden:1; =A0 =A0 =A0/* Hardware has FLHOLDCR and HOL=
DEN is set */
>> =A0};
>>
>> =A0struct sh_flctl_platform_data {
>> @@ -146,6 +157,7 @@ struct sh_flctl_platform_data {
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 flcmncr_val;
>>
>> =A0 =A0 =A0 unsigned has_hwecc:1;
>> + =A0 =A0 unsigned use_holden:1;
>> =A0};
>>
>> =A0static inline struct sh_flctl *mtd_to_flctl(struct mtd_info *mtdinfo)
>
> --
> Regards,
>
> Laurent Pinchart

thanks for all the reviews!

 Bastian
