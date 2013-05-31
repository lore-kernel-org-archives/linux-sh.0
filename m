From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2013 15:04:17 +0000
Subject: Re: [PATCH v2] dmaengine: shdma: fix a build failure on platforms with no DMA support
Message-Id: <4422231.HoYmB8LUsn@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1305310423360.1470@axis700.grange>
 <alpine.DEB.2.00.1305311504460.6919@axis700.grange> <51A8BB0D.9060907@ti.com>
In-Reply-To: <51A8BB0D.9060907@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 31 May 2013 10:00:29 Dan Murphy wrote:
> My consideration was that since this is an exported symbol that a driver
> could call this API explicitly without checking for
> the function pointer first, there is a potential of calling a NULL pointer.

Drivers never call a filter function directly, so that is not an issue.
Even if a driver would try it, that would not actually compile.
	
	Arnd
