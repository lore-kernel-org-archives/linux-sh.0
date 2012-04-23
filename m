From: Bastian Hecht <hechtb@googlemail.com>
Date: Mon, 23 Apr 2012 09:05:30 +0000
Subject: Re: [PATCH 8/9] mtd: sh_flctl: Use user oob data in hardware ECC mode
Message-Id: <CABYn4sx4SehvwHgP3m5i5Bg7_5FWTHHGMLL+n_R1YujwaU_MzA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
 <1334913230-23615-9-git-send-email-hechtb@gmail.com>
 <7855571.0NdFmdbNxx@avalon>
In-Reply-To: <7855571.0NdFmdbNxx@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hello Laurent,

2012/4/21 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Bastian,
>
> Thanks for the patch.
>
> On Friday 20 April 2012 11:13:49 Bastian Hecht wrote:
>> In hardware ecc mode, the flctl now writes and reads the oob data
>> provided by the user. Additionally the ECC is now returned in normal
>> page reads, not only when using the explicit NAND_CMD_READOOB command.
>
> For my information again, what's the purpose of returning OOB data if the
> caller hasn't requested it ? What are those data then used for ?

There is an active discussion going on whether to pass a boolean to
nand_{read,write} that indicates if we need oob data or not. I assume
this to make it into the mainline then I can adapt this to the flctl
driver. The data can be used by file systems or bad block marking or
any other organizational needs like wear leveling and so on.

Best regards,

 Bastian Hecht


>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>
> --
> Regards,
>
> Laurent Pinchart
>
