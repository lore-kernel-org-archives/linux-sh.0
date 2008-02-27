From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Feb 2008 01:29:49 +0000
Subject: Re: [PATCH 1/9] arch/sh/drivers/dma/dma-sh.c: Correct use of.and &
Message-Id: <20080227012949.GB20577@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0802262141450.18200@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.0802262141450.18200@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Tue, Feb 26, 2008 at 09:42:11PM +0100, Julia Lawall wrote:
> In commit e6bafba5b4765a5a252f1b8d31cbf6d2459da337, a bug was fixed that
> involved converting !x & y to !(x & y).  The code below shows the same
> pattern, and thus should perhaps be fixed in the same way.
> 
Indeed. Applied, thanks.
