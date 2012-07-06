From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Jul 2012 00:10:37 +0000
Subject: Re: [PATCH 1/2] mtd: sh_flctl: Use memcpy() instead of using a loop
Message-Id: <20120706001037.GE11036@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1341484862-24033-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1341484862-24033-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Bastian Hecht <hechtb@gmail.com>, linux-mtd@lists.infradead.org, Linux-SH <linux-sh@vger.kernel.org>

On Thu, Jul 05, 2012 at 12:41:01PM +0200, Bastian Hecht wrote:
> Elemets have been copied "manually" in a loop. Better use memcpy().
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Reviewed-by: Simon Horman <horms@verge.net.au>
