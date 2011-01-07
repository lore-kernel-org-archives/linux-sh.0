From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 Jan 2011 01:56:12 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 Enable SDIO IRQs for Mackerel
Message-Id: <20110107015612.GG22477@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110106105541.16675.33745.sendpatchset@t400s>
In-Reply-To: <20110106105541.16675.33745.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 06, 2011 at 07:55:41PM +0900, Magnus Damm wrote:
> Enable SDIO IRQ support for the Mackerel board.

This one needs the mackerel support merged, so I'll wait for Chris to
send the MMC merge, then pull that in to rmobile-latest along with
rmobile/sdio and then throw this on top for the next round.
