From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 28 Oct 2009 07:55:19 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: Add USB1 gadget support
Message-Id: <20091028075519.GA13259@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u3a54jag2.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u3a54jag2.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 28, 2009 at 03:31:57PM +0900, Kuninori Morimoto wrote:
> USB1 can change to host/function by checking PTB3.
> This patch add USB1 gadget support and check PTB3 when boot,
> and change name to usb1_common_XXX from usb1_host_XXX.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Applied, thanks.
