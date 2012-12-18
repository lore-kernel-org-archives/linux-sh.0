From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Dec 2012 00:37:17 +0000
Subject: Re: [PATCH 05/10] ARM: shmobile: Add DT table of INTC for sh7372
Message-Id: <20121218003717.GI7146@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355562224-29448-1-git-send-email-horms+renesas@verge.net.au>
 <1355562224-29448-6-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1212170941400.24007@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1212170941400.24007@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 17, 2012 at 09:44:10AM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Sat, 15 Dec 2012, Simon Horman wrote:
> 
> > From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > 
> > Cc: Magnus Damm <damm@opensource.se>
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> What happened to intcs support? Why has it been dropped? Without it many 
> important devices cannot be set up from DT, e.g. I2C #0.

INTCS support is still being worked on and doesn't seem to be
quite ready yet. I am aware that this limits the usefulness of
this series. But it is a step in the right direction.
