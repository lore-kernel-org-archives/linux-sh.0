From: Simon Horman <horms@verge.net.au>
Date: Tue, 22 May 2018 08:22:16 +0000
Subject: Re: [PATCH 1/2] media: arch: sh: ecovec: Remove calls to empty arch_setup_pdev_archdata()
Message-Id: <20180522082215.7jn6svwka65hid3s@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1526641611-2769-1-git-send-email-geert+renesas@glider.be>
 <1526641611-2769-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1526641611-2769-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Fri, May 18, 2018 at 01:06:50PM +0200, Geert Uytterhoeven wrote:
> SuperH doesn't implement arch_setup_pdev_archdata(), and falls back to
> the default (empty) implementation.  As this code is board-specific, the
> calls can just be removed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

