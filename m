From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Thu, 21 Feb 2008 22:47:57 +0000
Subject: Re: [PATCH 2.6.25] sh: revert dreamcast pci change
Message-Id: <1203634077.7028.6.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20080220091021.20631.4358.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080220091021.20631.4358.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Wed, 2008-02-20 at 18:10 +0900, Magnus Damm wrote:
> Commit e036eaa681a17f71b64f6d9040fe605555623919 broke dreamcast pci, this
> patch fixes that by reverting the dreamcast specific bits.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> Acked-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> ---
> 
>  arch/sh/drivers/pci/ops-dreamcast.c |   44 +++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> --- 0001/arch/sh/drivers/pci/ops-dreamcast.c
> +++ work/arch/sh/drivers/pci/ops-dreamcast.c	2008-02-20 17:56:48.000000000 +0900
> @@ -83,9 +83,9 @@ static int gapspci_read(struct pci_bus *


Just to confirm this patch does work but it doesn't apply cleanly - I
think you need to check the line numbers Magnus, otherwise I can just
post it as I've applied it.

