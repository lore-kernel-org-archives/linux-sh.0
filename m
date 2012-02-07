From: Simon Horman <horms@verge.net.au>
Date: Tue, 07 Feb 2012 03:03:03 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: r8a7779 PFC IPSR4 fix
Message-Id: <20120207030303.GA6320@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20120130022507.14954.36776.sendpatchset@w520>
In-Reply-To: <20120130022507.14954.36776.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 06, 2012 at 06:49:01PM -0800, Kuninori Morimoto wrote:
> 
> Hi
> 
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Fix the bit field width information for the IPSR4 register
> > in the r8a7779 pin function controller (PFC).
> > 
> > Without this fix the Marzen board fails to receive data
> > over the serial console due to misconfigured pin function
> > for the RX pin.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> 
> This patch solved marzen board SCIF issue.
> 
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Likewise,

Tested-by: Simon Horman <horms@verge.net.au>
