From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 15 Aug 2009 04:01:47 +0000
Subject: Re: [PATCH 00/04] sh: CONFIG_SUSPEND fixes for 2.6.31
Message-Id: <20090815040147.GA17061@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090815025307.8125.50234.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090815025307.8125.50234.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Aug 15, 2009 at 11:53:07AM +0900, Magnus Damm wrote:
> sh: CONFIG_SUSPEND fixes for 2.6.31
> 
> [PATCH 01/04] sh: skip disabled LCDC channels
> [PATCH 02/04] sh: CMT suspend/resume
> [PATCH 03/04] sh: use in-soc KEYSC on se7724
> [PATCH 04/04] sh: sh7724 ddr self-refresh changes  
> 
> These patches fix suspend-to-ram issues found in 2.6.31-rc. All
> are needed for proper suspend/resume support on Solution Engine 7724.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied to sh/for-2.6.31, thanks. This will be bound for -rc7.
