From: Bastian Hecht <hechtb@googlemail.com>
Date: Mon, 23 Apr 2012 08:51:49 +0000
Subject: Re: [PATCH 3/9] mtd: sh_flctl: Use different OOB layout
Message-Id: <CABYn4syhWVEABSs8LYO8bzhEmViSoFMtkM=yeihGZ9BLSUpUOg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
 <1334913230-23615-4-git-send-email-hechtb@gmail.com>
 <1514423.eX5bz1T5jX@avalon>
In-Reply-To: <1514423.eX5bz1T5jX@avalon>
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
>
> On Friday 20 April 2012 11:13:44 Bastian Hecht wrote:
>> The flctl hardware has changed and a new OOB layout must be adapted for
>> 2k page size NAND chips when using hardware ECC.
>> The related bit fields ECCPOS[0-2] are gone - the bits are marked as
>> reserved now in the datasheet. As there are no official users of the
>> hardware ECC so far, they are completely removed.
>>
>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>> ---
>> =A0drivers/mtd/nand/sh_flctl.c =A0| =A0 20 +++++++++++++-------
>> =A0include/linux/mtd/sh_flctl.h | =A0 =A04 ----
>> =A02 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
>> index 3c27921..411d783 100644
>> --- a/drivers/mtd/nand/sh_flctl.c
>> +++ b/drivers/mtd/nand/sh_flctl.c
>> @@ -44,11 +44,17 @@ static struct nand_ecclayout flctl_4secc_oob_16 =3D {
>> =A0};
>>
>> =A0static struct nand_ecclayout flctl_4secc_oob_64 =3D {
>> - =A0 =A0 .eccbytes =3D 10,
>> - =A0 =A0 .eccpos =3D {48, 49, 50, 51, 52, 53, 54, 55, 56, 57},
>> - =A0 =A0 .oobfree =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 {.offset =3D 60,
>> - =A0 =A0 =A0 =A0 =A0 =A0 . length =3D 4} },
>> + =A0 =A0 .eccbytes =3D 4 * 10,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .eccpos =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06, =A07, 8, =A09, 10, 11, 1=
2, 13, 14, 15,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22, 23, 24, 25, 26, 27, 28, 29=
, 30, 31,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 38, 39, 40, 41, 42, 43, 44, 45=
, 46, 47,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 54, 55, 56, 57, 58, 59, 60, 61=
, 62, 63 },
>
> Indentation mistake ?

Yes, thanks for noticing.

>> + =A0 =A0 =A0 =A0 =A0 =A0 .oobfree =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {.offset =3D 2, .length =3D 4},
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {.offset =3D 16, .length =3D 6=
},
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {.offset =3D 32, .length =3D 6=
},
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {.offset =3D 48, .length =3D 6=
} },
>
> Just for my information, where does that information come from ?

The first 2 bytes are used for bad block marking at the 1st page of
every erase block. This seems to be the default for all NAND chips
when they are marked by the manufacturer. The last 10 bytes are used
for ECC in each 16-bytes ECC hunk - I don't remember if I got this
info from the datasheet or by inspecting the page writes. BTW a page
is layed out this way: 512 bytes data / 16 bytes oob / 512 bytes data
/ 16 bytes oob / 512 bytes data / 16 bytes oob / 512 bytes data / 16
bytes oob. This leads to the code above.

Best regards,

 Bastian Hecht


>> =A0};
>>
>> =A0static uint8_t scan_ff_pattern[] =3D { 0xff, 0xff };
>> @@ -62,7 +68,7 @@ static struct nand_bbt_descr flctl_4secc_smallpage =3D=
 {
>>
>> =A0static struct nand_bbt_descr flctl_4secc_largepage =3D {
>> =A0 =A0 =A0 .options =3D NAND_BBT_SCAN2NDPAGE,
>> - =A0 =A0 .offs =3D 58,
>> + =A0 =A0 .offs =3D 0,
>> =A0 =A0 =A0 .len =3D 2,
>> =A0 =A0 =A0 .pattern =3D scan_ff_pattern,
>> =A0};
>> @@ -831,7 +837,7 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->ecc.mode =3D NAND_ECC_HW;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 4 symbols ECC enabled */
>> - =A0 =A0 =A0 =A0 =A0 =A0 flctl->flcmncr_base |=3D _4ECCEN | ECCPOS2 | E=
CCPOS_02;
>> + =A0 =A0 =A0 =A0 =A0 =A0 flctl->flcmncr_base |=3D _4ECCEN;
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->ecc.mode =3D NAND_ECC_SOFT;
>> =A0 =A0 =A0 }
>> diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
>> index 6832a90..91c5b01 100644
>> --- a/include/linux/mtd/sh_flctl.h
>> +++ b/include/linux/mtd/sh_flctl.h
>> @@ -49,7 +49,6 @@
>> =A0#define =A0 =A0 =A0FLERRADR(f) =A0 =A0 =A0 =A0 =A0 =A0 (f->reg + 0x98)
>>
>> =A0/* FLCMNCR control bits */
>> -#define ECCPOS2 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 25)
>> =A0#define _4ECCCNTEN =A0 (0x1 << 24)
>> =A0#define _4ECCEN =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 23)
>> =A0#define _4ECCCORRECT (0x1 << 22)
>> @@ -59,9 +58,6 @@
>> =A0#define QTSEL_E =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 17)
>> =A0#define ENDIAN =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << 16) =A0 =A0 /* 1 =
=3D little endian */
>> =A0#define FCKSEL_E =A0 =A0 (0x1 << 15)
>> -#define ECCPOS_00 =A0 =A0(0x00 << 12)
>> -#define ECCPOS_01 =A0 =A0(0x01 << 12)
>> -#define ECCPOS_02 =A0 =A0(0x02 << 12)
>> =A0#define ACM_SACCES_MODE =A0 =A0 =A0(0x01 << 10)
>> =A0#define NANWF_E =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 9)
>> =A0#define SE_D =A0 =A0 =A0 =A0 (0x1 << 8) =A0 =A0 =A0/* Spare area disa=
ble */
> --
> Regards,
>
> Laurent Pinchart
>
