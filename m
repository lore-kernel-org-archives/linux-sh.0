From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 04 Aug 2009 06:09:08 +0000
Subject: Re: [PATCH 00/09] sh: Runtime PM pdev hwblk
Message-Id: <20090804060908.GD21171@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090731074705.29009.33769.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090731074705.29009.33769.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 31, 2009 at 04:47:05PM +0900, Magnus Damm wrote:
> sh: Runtime PM pdev hwblk changes
> 
> [PATCH 01/09] sh: Runtime PM pdev hwblk - header change
> [PATCH 02/09] sh: Runtime PM pdev hwblk - sh7722
> [PATCH 03/09] sh: Runtime PM pdev hwblk - Migo-R
> [PATCH 04/09] sh: Runtime PM pdev hwblk - Solution Engine 7722
> [PATCH 05/09] sh: Runtime PM pdev hwblk - sh7723
> [PATCH 06/09] sh: Runtime PM pdev hwblk - AP325RXA
> [PATCH 07/09] sh: Runtime PM pdev hwblk - sh7724
> [PATCH 08/09] sh: Runtime PM pdev hwblk - kfr2r09
> [PATCH 09/09] sh: Runtime PM pdev hwblk - Solution Engine 7724
> 
I've merged the series in to the sh/hwblk topic branch, based on top of
Rafael's for-linus branch. I'll leave it there until Rafael pushes to
Linus, and then push it out with the next round of updates for the merge
window.

If the run-time pm core makes its way in at some point as well, then I'll
handle that the same way.
