From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 Feb 2008 05:21:38 +0000
Subject: Re: [PATCH] arch/sh/drivers/heartbeat.c ioremap is expected to succeed
Message-Id: <20080226052138.GC19814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <47B98376.5040906@tiscali.nl>
In-Reply-To: <47B98376.5040906@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roel Kluin <12o3l@tiscali.nl>
Cc: linux-sh@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Mon, Feb 18, 2008 at 02:09:10PM +0100, Roel Kluin wrote:
> !unlikely(hd->base) is equivalent to likely(!hd->base) (for instance see
> comments with commit fd312561adcc90e924f35d3032d5493aeb4c3017), I think
> the ioremap is expected to succeed? please confirm that's right.
> The patch below was *not* tested.
> ---
> ioremap is expected to succeed
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Indeed it is. Applied, thanks.
