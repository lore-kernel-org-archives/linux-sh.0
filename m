From: Stephen Warren <swarren@wwwdotorg.org>
Date: Fri, 28 Feb 2014 20:27:24 +0000
Subject: Re: [PATCH 1/7] ARM: dts: tegra: add PCIe interrupt mapping properties
Message-Id: <5310F12C.7030500@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <1393608523-17509-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1393608523-17509-2-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/28/2014 10:28 AM, Lucas Stach wrote:
> Those are defined by the common PCI binding.

I have no reason to object to the two Tegra patches, but I'll wait for
Thierry to take a closer look.

I expect once he does, I would apply patch 1/7 through the Tegra tree,
and Bjorn would take patch 2/7 through the PCI tree. Does that make sense?
