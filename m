From: Simon Horman <horms@verge.net.au>
Date: Thu, 13 Jun 2013 06:15:48 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove Bonito board support
Message-Id: <20130613061546.GB15354@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehc6lhm9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehc6lhm9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 13, 2013 at 02:25:08PM +0900, Simon Horman wrote:
> On Wed, Jun 12, 2013 at 10:11:46PM -0700, Kuninori Morimoto wrote:
> > Remove board support for the r8a7740 based Bonito board
> > 
> > The r8a7740 SoC support code is still kept around since it
> > is in use by the Armadillo800eva board which is basically a more
> > recent board where the design is based on Bonito.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > >> Simon
> > 
> > This patch is based on cleanup-boot branch
> 
> Thanks, I will queue this up.

It is now present in the cleanup-boot branch.
