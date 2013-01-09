From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Jan 2013 02:06:47 +0000
Subject: Re: [PATCH 1/2] ARM: r8a7740: Add interim sh-eth device name to clocks list
Message-Id: <20130109020647.GB6496@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
 <1355851359-8871-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1355851359-8871-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 18, 2012 at 06:22:38PM +0100, Bastian Hecht wrote:
> When we use the ethernet device via DT setup, we need to add it
> to a lookup list until this is properly handled later in a DT-only
> fashion.

Thanks, looks good.
I will apply this.
