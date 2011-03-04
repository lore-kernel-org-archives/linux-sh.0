From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Mar 2011 06:03:26 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: modify LCDC clock divider value
Message-Id: <20110304060326.GA13621@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3poc5thoz6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3poc5thoz6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 02, 2011 at 06:05:21PM +0900, Kuninori Morimoto wrote:
> mackerel WVGA LCDC panel expect 33.3MHz for dot-clock,
> but current dot-clock was 50.0MHz.
> This patch modify clock divider value.

On Wed, Mar 02, 2011 at 06:05:44PM +0900, Kuninori Morimoto wrote:
> ap4evb WVGA LCDC panel expect 33.3MHz for dot-clock,
> but current dot-clock was 50.0MHz.
> This patch modify clock divider value.

Both applied for .38, thanks.
