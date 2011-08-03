From: Simon Horman <horms@verge.net.au>
Date: Wed, 03 Aug 2011 04:00:46 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 SCIF platform data update
Message-Id: <20110803040045.GA21057@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110802094952.2785.67371.sendpatchset@t400s>
In-Reply-To: <20110802094952.2785.67371.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 03, 2011 at 12:38:45PM +0900, Paul Mundt wrote:
> On Wed, Aug 03, 2011 at 12:27:40PM +0900, Simon Horman wrote:
> > On Tue, Aug 02, 2011 at 06:49:52PM +0900, Magnus Damm wrote:
> > > From: Magnus Damm <damm@opensource.se>
> > > 
> > > Add .regtype members to the sh7372 SCIF platform data.
> > > 
> > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > 
> > Tested-by: Simon Horman <horms@verge.net.au>
> 
> This has since been fixed elsewhere. It turns out I fumbled the error
> checking from the default probe path.

Ok, let me know if there is an alternate patch/tree you would like me to test.
