From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 Mar 2012 15:19:56 +0000
Subject: Re: [PATCH v3 1/7] mtd: sh_flctl: Expand FLCMNCR register bit field
Message-Id: <1453489.YgpPZckSA6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hi Bastian,

Thanks for the patches.

On Thursday 01 March 2012 10:48:35 Bastian Hecht wrote:
> Add support for a new hardware generation. The meaning of some bits
> of the FLCMNCR register changed, so some new defines are added
> parallel to the existing ones to keep backward compatibility.
> 
> The defines allow to choose an appropriate clocking scheme.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

For the whole set,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
