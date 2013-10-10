From: Simon Horman <horms@verge.net.au>
Date: Thu, 10 Oct 2013 07:23:17 +0000
Subject: Re: [PATCH] ARM: shmobile: Select GPIO in case of the r7s72100 SoC
Message-Id: <20131010072313.GA23789@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131009225742.7558.62495.sendpatchset@w520>
In-Reply-To: <20131009225742.7558.62495.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 10, 2013 at 07:57:42AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The r7s72100 contains GPIO controllers so make sure the GPIO
> subsystem can be built by selecting ARCH_WANT_OPTIONAL_GPIOLIB.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.
