From: Brian Norris <computersforpeace@gmail.com>
Date: Wed, 25 Apr 2012 17:57:40 +0000
Subject: Re: [PATCH v2 09/10] mtd: sh_flctl: Use user oob data in hardware ECC mode
Message-Id: <CAN8TOE9fnQJb6ivwg997cE93g+PcxvvgZzGHsm2Ua6o_ZzH=HQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
 <1335362618-4559-10-git-send-email-hechtb@gmail.com>
In-Reply-To: <1335362618-4559-10-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

On Wed, Apr 25, 2012 at 7:03 AM, Bastian Hecht <hechtb@googlemail.com> wrote:
> In hardware ecc mode, the flctl now writes and reads the oob data
> provided by the user. Additionally the ECC is now returned in normal
> page reads, not only when using the explicit NAND_CMD_READOOB command.

I don't know about the HW-specific details here, but read/write
data+OOB seems good.

Acked-by: Brian Norris <computersforpeace@gmail.com>

If these patches are accepted, I will try to make sure this driver
switches to conditionally reading/writing OOB in my patch series. Keep
an eye out for them, though.

BTW, from the changes I'm seeing in this patch series, your driver was
previously fairly broken. Or at least, several features of it were...
Good luck with the cleanup!

Brian
