From: Simon Horman <horms@verge.net.au>
Date: Fri, 22 May 2015 01:23:45 +0000
Subject: Re: [PATCH v2 00/15] r8a7793 SoC, Gose board support
Message-Id: <20150522012342.GA27511@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 21, 2015 at 12:47:50PM +0200, Ulrich Hecht wrote:
> On Tue, May 12, 2015 at 6:15 AM, Simon Horman <horms@verge.net.au> wrote:
> > Once basic support has been merged further support can be added in an
> > incremental manner as the bindings and other driver support becomes ready
> > (merged).
> 
> Since a large number of small issues have been identified in this
> version, I will post another one in the same arrangement with all that
> stuff fixed first.
> 
> > I am more than happy to offer assistance, please feel free to contact me
> > privately or on-list.
> 
> Gladly, thank you.
> 
> Now that the PFC patches have been picked up by Linus Walleij, will it
> still be necessary to exclude PFC dependencies in the next iteration?

That is still my preference as I believe it will be easiest in the short
to medium term. We can focus on small steps rather than getting
everything ready all at once.
