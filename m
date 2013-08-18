From: Simon Horman <horms@verge.net.au>
Date: Sun, 18 Aug 2013 04:03:39 +0000
Subject: Re: [GIT PULL 0/2] Renesas ARM based SoC boards cleanups for v3.12
Message-Id: <20130818040339.GE30709@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375842006.git.horms+renesas@verge.net.au>
 <20130814081242.GJ30577@quad.lixom.net>
In-Reply-To: <20130814081242.GJ30577@quad.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 14, 2013 at 01:12:42AM -0700, Olof Johansson wrote:
> On Wed, Aug 07, 2013 at 01:36:37PM +0900, Simon Horman wrote:
> > Hi Olof, Hi Arnd,
> > 
> > please consider these Renesas ARM based SoC boards cleanups for v3.12.
> > 
> > This pull-request is based on renesas-boards-for-v3.12,
> > which I have previously sent a pull-request for.
> > 
> > I have separated these cleanups from those that I included
> > in renesas-cleanup3-for-v3.12 as there are different dependencies
> > involved and this approach seemed simpler somehow.
> > 
> > 
> > The following changes since commit f79d68da510bf1b95beff4d556b78d06801f11dc:
> > 
> >   ARM: shmobile: ape6evm: add SDHI interfaces (2013-07-25 14:46:38 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-cleanup-for-v3.12
> 
> Pulled, thanks. FWIW, this could have been baked into boards2.

Thanks. To be honest I am rather unclear on when something should go in a
cleanup branch and when it shouldn't.
