From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 07 Jun 2008 02:39:12 +0000
Subject: Re: sh: Add supoprt SCIF2 of SH7763
Message-Id: <20080607023912.GA6961@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4848E33F.2070700@renesas.com>
In-Reply-To: <4848E33F.2070700@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 06, 2008 at 04:11:59PM +0900, Nobuhiro Iwamatsu wrote:
> SH7763 has 3 SCIF device. Current code supports SCIF0 and 1.
> SCIF0 and 1 are same register constitution, but only SCIF2 is different.
> I added support of SCIF2.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Added to the 2.6.27 queue, thanks.
