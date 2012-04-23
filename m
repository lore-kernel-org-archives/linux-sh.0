From: Bastian Hecht <hechtb@googlemail.com>
Date: Mon, 23 Apr 2012 09:36:29 +0000
Subject: Re: [PATCH 8/9] mtd: sh_flctl: Use user oob data in hardware ECC mode
Message-Id: <CABYn4sxbXiOkdPps59gkOj2MiYZXkeqgKTXt7i7HTz17VqWk0Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
 <1334913230-23615-9-git-send-email-hechtb@gmail.com>
 <7855571.0NdFmdbNxx@avalon>
 <CABYn4sx4SehvwHgP3m5i5Bg7_5FWTHHGMLL+n_R1YujwaU_MzA@mail.gmail.com>
In-Reply-To: <CABYn4sx4SehvwHgP3m5i5Bg7_5FWTHHGMLL+n_R1YujwaU_MzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

2012/4/23 Bastian Hecht <hechtb@googlemail.com>:
> Hello Laurent,
>
> 2012/4/21 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
>> Hi Bastian,
>>
>> Thanks for the patch.
>>
>> On Friday 20 April 2012 11:13:49 Bastian Hecht wrote:
>>> In hardware ecc mode, the flctl now writes and reads the oob data
>>> provided by the user. Additionally the ECC is now returned in normal
>>> page reads, not only when using the explicit NAND_CMD_READOOB command.
>>
>> For my information again, what's the purpose of returning OOB data if the
>> caller hasn't requested it ? What are those data then used for ?
>
> There is an active discussion going on whether to pass a boolean to
> nand_{read,write} that indicates if we need oob data or not. I assume
> this to make it into the mainline then I can adapt this to the flctl
> driver. The data can be used by file systems or bad block marking or
> any other organizational needs like wear leveling and so on.

I'm unsure if I missed your point here - we just don't know if we need
it or not. The discussion I mentioned primarily takes place here at
the mtd mailing list:

[PATCH 1/2] mtd: nand: add OOB argument to NAND {read,write}_page interfaces
http://lists.infradead.org/pipermail/linux-mtd/2012-April/040714.html

Now I'm confused as well whether I should skip the read oob part of the pat=
ch.
I'll skip the read part of the patch until a decision is made, I think.

Best regards,

 Bastian Hecht


> Best regards,
>
> =A0Bastian Hecht
>
>
>>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>>
>> --
>> Regards,
>>
>> Laurent Pinchart
>>
