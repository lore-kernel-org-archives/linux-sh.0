From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Fri, 09 Mar 2012 12:48:51 +0000
Subject: Re: [PATCH v3 1/7] mtd: sh_flctl: Expand FLCMNCR register bit field
Message-Id: <1331297331.29445.19.camel@sauron.fi.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

On Thu, 2012-03-01 at 10:48 +0100, Bastian Hecht wrote:
> Add support for a new hardware generation. The meaning of some bits
> of the FLCMNCR register changed, so some new defines are added
> parallel to the existing ones to keep backward compatibility.
> 
> The defines allow to choose an appropriate clocking scheme.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Pushed the patch-set to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy

