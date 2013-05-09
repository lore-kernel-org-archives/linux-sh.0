From: Simon Horman <horms@verge.net.au>
Date: Thu, 09 May 2013 04:20:31 +0000
Subject: Re: [PATCH] ARM: shmobile: fix sleep-r8a7740.S miscompiles
Message-Id: <20130509042031.GA7832@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201305081418.05091.arnd@arndb.de>
 <20130509032544.GB13994@verge.net.au>
In-Reply-To: <20130509032544.GB13994@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, May 09, 2013 at 12:25:44PM +0900, Simon Horman wrote:
> On Wed, May 08, 2013 at 02:18:04PM +0200, Arnd Bergmann wrote:
> > The newly added sleep-r8a7740.S file in shmobile does not
> > actually build because of renamed symbols.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Bastian Hecht <hechtb+renesas@gmail.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > 
> > Simon, please apply to whichever branch of yours has the broken commit,
> > or fold this patch into Bastian's patch.
> > 
> > linux-next doesn't build for me because of this, mainline is still fine.
> 
> Sure, will do.
> 
> I am traveling today so I may not be able to deal with this
> properly until tomorrow.

I have queued this up in the soc-r8a7740 branch, where the problem was
added. I have pushed this branch along with a refreshed next branch.
This change should appear in linux-next in the not to distant future.
