From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 25 Apr 2012 13:26:16 +0000
Subject: Re: [PATCH 8/9] mtd: sh_flctl: Use user oob data in hardware ECC mode
Message-Id: <CABYn4sxg9+kC4256_snAQaAWZ4jwMpuKf3StUGbJ2tXQA0SFdw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
 <CABYn4sx4SehvwHgP3m5i5Bg7_5FWTHHGMLL+n_R1YujwaU_MzA@mail.gmail.com>
 <CABYn4sxbXiOkdPps59gkOj2MiYZXkeqgKTXt7i7HTz17VqWk0Q@mail.gmail.com>
 <5280156.KyNjAmSTh8@avalon>
 <CAN8TOE9oAbLPSSO5P+U=DJk_vhjF0DgM0mBO7QyYE7zAOwbnmw@mail.gmail.com>
In-Reply-To: <CAN8TOE9oAbLPSSO5P+U=DJk_vhjF0DgM0mBO7QyYE7zAOwbnmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, Shmulik Ladkani <shmulik.ladkani@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

>> My point was just that it was pointless to read/write OOB data if the caller
>> doesn't use them. It's an optimization: reading OOB data won't hurt regardless
>> of what the caller does with it, but it will use CPU time and power for no
>> reason. Adding an OOB argument to the {read,write}_page function would make
>> this explicit.
>
> Right, it is pointless and should be changed fairly soon, if my
> patches go through. But until the additional argument is added, you
> cannot guarantee that the interface wasn't expecting both data+OOB to
> be read. For instance, the mtd_read_oob interface may call
> nand_do_read_ops() with non-null datbuf and oobbuf. We have just such
> a case in mtdswap.c and nand_bbt.c, I think. See Shmulik's comments
> here (some of which only apply to mtd_write_oob):
>
> http://lists.infradead.org/pipermail/linux-mtd/2012-April/040800.html
>
> Brian

So after some back and forth, I'll leave the 8/9 patch as it is to
ensure compliance to the nand base code and wait for Brian's patches
to make it into the mainline.

Best regards,

 Bastian Hecht
