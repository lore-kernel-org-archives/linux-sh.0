From: David Miller <davem@davemloft.net>
Date: Thu, 20 Mar 2014 21:22:41 +0000
Subject: Re: [PATCH 0/5] sh_eth: Fix the race between open and MDIO bus registration
Message-Id: <20140320.172241.930093531135287233.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1395324035-22918-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395324035-22918-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: laurent.pinchart+renesas@ideasonboard.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com, ben.dooks@codethink.co.uk

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 20 Mar 2014 15:00:30 +0100

> This patch series fixes the race condition that exists in the sh_eth driver
> between network device open and MDIO bus registration. The actual fix is in
> patch 4/5, with previous patches preparing the driver and patch 5/5 cleaning
> up an unrelated issue.
> 
> I've based the idea on Sergei's attempt to fix the problem and can successfully
> boot the Koelsch board over NFS with this series. I might have missed other
> issues though, hence the RFC status.
> 
> The patches are based on top of the latest net-next master branch.

Series applied to net-next, thanks.
