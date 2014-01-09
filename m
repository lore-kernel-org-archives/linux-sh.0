From: Simon Horman <horms@verge.net.au>
Date: Thu, 09 Jan 2014 05:13:11 +0000
Subject: Re: [PATCH 0/8] ARM: shmobile: Conditionally select SMSC_PHY
Message-Id: <20140109051311.GH2132@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 07, 2014 at 05:48:00PM +0900, Simon Horman wrote:
> Select the SMSC_PHY if ethernet is enabled on shmbile boards
> that have an SMSC phy. This allows the SMSC-specific phy driver
> to be used rather than relying on generic phy code.
> 
> Based on the renesas-devel-v3.13-rc7-20140107 tag
> of my renesas tree.

I have queued up these changes.
