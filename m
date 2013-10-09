From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Oct 2013 02:01:12 +0000
Subject: Re: [PATCH] ARM: shmobile: Select IRQC in case of the r8a7791 SoC
Message-Id: <20131009020111.GA15065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131008031608.10122.53864.sendpatchset@w520>
In-Reply-To: <20131008031608.10122.53864.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 08, 2013 at 12:16:08PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The r8a7791 contains IRQC hardware so make sure
> the driver gets built by selecting RENESAS_IRQC.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.
