From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 16 May 2012 09:37:02 +0000
Subject: Re: [PATCH v4 8/8] mtd: sh_flctl: Use user oob data in hardware ECC mode
Message-Id: <CABYn4sy5MPv42tBBDJX4N+cdJ3Vjc2HA3d=0wWT+9v9gz=bZvQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
 <1336997687-6868-9-git-send-email-hechtb@gmail.com>
 <CAN8TOE9sq56X_VUgi+ZujLRPs=SpcJm9a1N-NuzF6+6R2WPLAg@mail.gmail.com>
In-Reply-To: <CAN8TOE9sq56X_VUgi+ZujLRPs=SpcJm9a1N-NuzF6+6R2WPLAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Brian Norris <computersforpeace@gmail.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, linux-sh@vger.kernel.org, magnus.damm@gmail.com, Bastian Hecht <hechtb@gmail.com>, linux-mtd@lists.infradead.org, laurent.pinchart@ideasonboard.com

Hello Brian,

Artem pushed the set and I'll supply a follow-up patch containing your
suggestion.

Thanks,

Bastian


2012/5/14 Brian Norris <computersforpeace@gmail.com>:
> On Mon, May 14, 2012 at 5:14 AM, Bastian Hecht <hechtb@googlemail.com> wr=
ote:
>> diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
>> index 631f7ed..8a07212 100644
>> --- a/drivers/mtd/nand/sh_flctl.c
>> +++ b/drivers/mtd/nand/sh_flctl.c
>> @@ -384,6 +395,7 @@ static int flctl_read_page_hwecc(struct mtd_info *mt=
d, struct nand_chip *chip,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint8_t *=
buf, int oob_required, int page)
>> =A0{
>> =A0 =A0 =A0 =A0chip->read_buf(mtd, buf, mtd->writesize);
>> + =A0 =A0 =A0 chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>
> Well, my 'oob_required' patches won the race for inclusion in
> l2-mtd-2.6.git, so it's probably good to just use the 'oob_required'
> parameter now. That is:
>
> if (oob_required)
> =A0 =A0 =A0 chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
>
>> @@ -391,6 +403,7 @@ static void flctl_write_page_hwecc(struct mtd_info *=
mtd, struct nand_chip *chip,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cons=
t uint8_t *buf, int oob_required)
>> =A0{
>> =A0 =A0 =A0 =A0chip->write_buf(mtd, buf, mtd->writesize);
>> + =A0 =A0 =A0 chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
>> =A0}
>
> Similar here:
>
> if (oob_required)
> =A0 =A0 =A0 chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
>
> Brian
