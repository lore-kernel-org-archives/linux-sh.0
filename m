From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Dec 2008 04:28:29 +0000
Subject: Re: [PATCH] SH: Delete unnecessary mov in the top of interrupt
Message-Id: <20081210042829.GB27356@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <493D295B.1010806@gmail.com>
In-Reply-To: <493D295B.1010806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 08, 2008 at 11:04:11PM +0900, shinkoi2005 wrote:
> I think that to move INTEVT address to the scratch reg in the top of
> interrupt is already unnecessary.
> So this patch delete it.
> 
> Signed-off-by: Aoi Shinkai <shinkoi2005@gmail.com>

That is indeed the case, good catch!

Applied, thanks.
