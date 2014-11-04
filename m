From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Nov 2014 00:21:34 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: Board removal festivities
Message-Id: <20141104002133.GA22891@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 04:46:47PM +0900, Magnus Damm wrote:
> ARM: shmobile: Board removal festivities
> 
> [PATCH 01/03] ARM: shmobile: lager-reference: DTS-only board support
> [PATCH 02/03] ARM: shmobile: lager: Remove legacy board support
> [PATCH 03/03] ARM: shmobile: mackerel: Remove legacy board support
> 
> Rework Lager to be supported by DTS only and phase out the old
> Mackerel board support code. SoC code is not touched due to merge
> dependencies, so r8a7790 and sh7372 legacy SoC code is still around.
> 
> Simon, do you want me to remove legacy SoC code as well, or shall we wait?

Yes, I think so.

I think you should also remove the legacy defconfigs and
their references in the MAINTAINERS file.
