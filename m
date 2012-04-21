From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 21 Apr 2012 15:00:36 +0000
Subject: Re: [PATCH 8/9] mtd: sh_flctl: Use user oob data in hardware ECC mode
Message-Id: <7855571.0NdFmdbNxx@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
 <1334913230-23615-9-git-send-email-hechtb@gmail.com>
In-Reply-To: <1334913230-23615-9-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hi Bastian,

Thanks for the patch.

On Friday 20 April 2012 11:13:49 Bastian Hecht wrote:
> In hardware ecc mode, the flctl now writes and reads the oob data
> provided by the user. Additionally the ECC is now returned in normal
> page reads, not only when using the explicit NAND_CMD_READOOB command.

For my information again, what's the purpose of returning OOB data if the 
caller hasn't requested it ? What are those data then used for ?

> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

-- 
Regards,

Laurent Pinchart

