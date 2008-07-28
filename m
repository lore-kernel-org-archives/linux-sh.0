From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 10:19:08 +0000
Subject: Re: [PATCH] sh: fix uImage Entry Point
Message-Id: <20080728101908.GB14825@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4886E272.6060108@renesas.com>
In-Reply-To: <4886E272.6060108@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 23, 2008 at 04:49:06PM +0900, Yoshihiro Shimoda wrote:
> fix the problem that cannot boot using uImage when PAGE_SIZE is
> 8kbyte or 64kbyte.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Applied, thanks.
