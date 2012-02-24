From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Feb 2012 04:41:50 +0000
Subject: Re: [PATCH] sh: modify a resource of sh_eth_giga1_resources in board-sh7757lcr
Message-Id: <20120224044150.GF9994@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F4203CA.3040303@renesas.com>
In-Reply-To: <4F4203CA.3040303@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 20, 2012 at 05:26:50PM +0900, Shimoda, Yoshihiro wrote:
> The latest sh_eth driver needs a resource of TSU in the channel 1,
> if the controller has TSU registers. So, this patch adds the resource.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied, thanks.
