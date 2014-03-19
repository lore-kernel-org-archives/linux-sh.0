From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Mar 2014 16:12:15 +0000
Subject: Re: [PATCH/RFC 0/5] Fix the sh_eth race between open and MDIO bus registration
Message-Id: <5329CFE9.50901@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 03/19/2014 02:25 AM, Laurent Pinchart wrote:

> This patch series attempts to fix the race condition that exists in the sh_eth
> driver between network device open and MDIO bus registration. The actual fix
> is in patch 4/5, with previous patches preparing the driver and patch 5/5
> cleaning up an unrelated issue.

> I've based the idea on Sergei's attempt to fix the problem and can successfully
> boot the Koelsch board over NFS with this series. I might have missed other
> issues though, hence the RFC status.

> The patches are based on top of Simon's latest devel branch plus the following
> two patches

> 	sh_eth: add device tree support
> 	sh_eth: update OF PHY registeration

    Oops, I have forgotten to mention these two patches when specifying the 
dependencies of my patch. :-/

> Sergei, assuming this series gets accepted, should I send it to the netdev
> mailing list or would you like to take it in your tree to avoid conflicts ?

    Send them to netdev, I don't have pending patches to 'sh_eth' against 
'net-next.git', so you would just need to rebase against this repo where my 
recent 4 patches have been already merged.

WBR, Sergei

