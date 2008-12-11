From: Steve.Glendinning@smsc.com
Date: Thu, 11 Dec 2008 10:49:06 +0000
Subject: Re: [PATCH 4/6] smsc911x: convert ap325rxa platform to use smsc911x
Message-Id: <OFEC27AD62.5D8D064A-ON8025751C.003B1D21-8025751C.003B8351@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49266715.9090705@renesas.com>
In-Reply-To: <49266715.9090705@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

The first two patches in this set (platform independant) are in the 
net-next tree for merging in 2.6.29.  I guess the three sh-specific 
patches would make more sense to merge via the sh tree, but they depend on 
1 and 2.  Do we need to wait until the merge window is open to add these?

Please let me know if you want me to re-send the 3 sh patches.

Regards,
--
Steve Glendinning
SMSC GmbH
m: +44 777 933 9124
e: steve.glendinning@smsc.com





Paul Mundt <lethal@linux-sh.org> 
21/11/2008 07:46

To
Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
cc
Steve Glendinning/SMSC@SMSC, netdev@vger.kernel.org, 
catalin.marinas@arm.com, Bahadir.Balban@arm.com, dustin@sensoria.com, 
bgat@billgatliff.com, Ian Saturley/SMSC@SMSC, g.liakhovetski@gmx.de, Peter 
Korsgaard <jacmet@sunsite.dk>, Linux-sh <linux-sh@vger.kernel.org>
Subject
Re: [PATCH 4/6] smsc911x: convert ap325rxa platform to use smsc911x






On Fri, Nov 21, 2008 at 04:45:25PM +0900, Nobuhiro Iwamatsu wrote:
> Steve Glendinning wrote:
> > Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
> > ---
> >  arch/sh/boards/board-ap325rxa.c    |   24 +++++++++++++-----------
> >  arch/sh/configs/ap325rxa_defconfig |   21 +++++++++++++++++++--
> >  2 files changed, 32 insertions(+), 13 deletions(-)
> 
> Tested-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Acked-by: Paul Mundt <lethal@linux-sh.org>


