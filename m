From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 11 Jul 2011 09:31:24 +0000
Subject: Re: [PATCH 0/6] clk: Initial feedback for off-SoC slow bus clocks
Message-Id: <20110711093124.GA3239@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
In-Reply-To: <20110711025344.GA27497@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jul 11, 2011 at 11:53:44AM +0900, Mark Brown wrote:
> The biggest issue I ran into was that as the clocks are all registered
> by name with the API if you've got two instances of the same off-SoC
> device in the system you'll not be able to disambiguate between the
> clocks it provides.

Sigh.  That sounds like yet more trash.  Obviously whoever thought
up that doesn't actually understand clks.
