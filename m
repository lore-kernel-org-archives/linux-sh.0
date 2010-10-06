From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Oct 2010 08:03:53 +0000
Subject: Re: [PATCH] sh: Fix multiple definition of intc_balancing_enable
Message-Id: <20101006080352.GD15712@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1286351860-18777-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1286351860-18777-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 06, 2010 at 04:57:40PM +0900, Nobuhiro Iwamatsu wrote:
> If CONFIG_INTC_BALANCING is not defined, intc_balancing_disable and
> other are defined multiple.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Thanks, Magnus alerted me about this too, I just pushed the same fix a
few minutes ago. Who knew people still build UP kernels.. :-)
