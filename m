From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 18 Jun 2011 09:52:14 +0000
Subject: Re: [PATCH] input: sh_keysc: 8x8 MODE_6 fix
Message-Id: <20110618095214.GA2401@core.coreip.homeip.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20110615143340.21798.61858.sendpatchset@t400s>
 <20110615231211.GC28947@verge.net.au>
In-Reply-To: <20110615231211.GC28947@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-input@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Thu, Jun 16, 2011 at 08:12:18AM +0900, Simon Horman wrote:
> On Wed, Jun 15, 2011 at 11:33:40PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > The MODE_6 support in sh_keysc.c is incorrect without
> > this patch. According to the data sheet for G4, AP4 and
> > AG5 KEYSC MODE_6 is 8x8 keys. Bump up MAXKEYS to 64 too.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Reviewed-by: Simon Horman <horms@verge.net.au>
> 

Applied, thanks!

-- 
Dmitry
