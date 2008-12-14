From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 14 Dec 2008 12:16:14 +0000
Subject: Re: [PATCH 5/5] sh: Enable GENERIC_HARDIRQS_NO__DO_IRQ for all SuperH32 machines
Message-Id: <20081214121614.GA24189@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <e4ec8d503ce1f10f5787b0697ee2364c3613fee1.1229255348.git.mjf@gentoo.org>
In-Reply-To: <e4ec8d503ce1f10f5787b0697ee2364c3613fee1.1229255348.git.mjf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 14, 2008 at 12:02:28PM +0000, Matt Fleming wrote:
> After the recent changes to switch SuperH board support over to irq_chip
> it is now possible to set GENERIC_HARDIRQS_NO__DO_IRQ for all SuperH
> boards.
> 
> Signed-off-by: Matt Fleming <mjf@gentoo.org>

With cayman converted, SUPERH64 can use it also, so the dependency is
superfluous at this point.
