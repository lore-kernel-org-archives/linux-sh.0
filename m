From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 19 Mar 2014 08:23:31 +0000
Subject: Re: [PATCH 0/2] Lager & Koelsch: Set ethernet PHY LED mode
Message-Id: <53295403.2010908@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1395165888-1498-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395165888-1498-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 18/03/14 19:04, Laurent Pinchart wrote:
> Hello,
>
> These two patches set the ethernet PHY LED mode to output etherner link status
> on LED0 for the Lager and Koelsch board.
>
> Both have a runtime dependency on "sh_eth: update OF PHY registeration" and
> "phy: micrel: add of configuration for LED mode" (scheduled for merge in v3.15)
> to have any effect. Without those dependencies the led-mode property will be
> ignored. The patches can thus be merged separately.
>
> Ben, I haven't seen similar patches being posted to the linux-sh mailing list,
> but I might have missed them. I apologize if that's the case.

It is entirely possible they have been missed, there is so much
outstanding at the moment that it is easy to miss the odd patch :/


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
