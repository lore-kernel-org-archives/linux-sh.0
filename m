From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Fri, 25 Jan 2013 18:21:37 +0000
Subject: Re: [PATCH/RFC 2/3] ethernet: add a PHY reset GPIO DT binding to sh_eth
Message-Id: <20130125182137.GB7393@obsidianresearch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
 <1359043653-11374-3-git-send-email-g.liakhovetski@gmx.de>
 <7921225.sfO3PIeLVS@avalon>
 <Pine.LNX.4.64.1301251127460.17518@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1301251127460.17518@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 25, 2013 at 11:34:55AM +0100, Guennadi Liakhovetski wrote:

> > Is there no need to reset the phy at runtime ?
> 
> No idea, I'm not developing the driver, I'm just porting one specific 
> feature from one API to another with no functional changes (apart from 
> postponing setting the GPIO).

Generally Linux relies on resetting the phy via the inband MDIO method,
which is what Linux does. It is pretty much never required to reset
via the hard pin - but you do need to generate a robust reset edge on
the reset pin once after power up.

Jason
