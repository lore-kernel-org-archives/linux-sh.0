From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 16 Dec 2009 04:27:01 +0000
Subject: Re: [PATCH] sh: Fix test of unsigned in se7722_irq_demux()
Message-Id: <20091216042700.GB31265@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B27BB12.1050008@gmail.com>
In-Reply-To: <4B27BB12.1050008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Dec 15, 2009 at 05:36:34PM +0100, Roel Kluin wrote:
> se7722_fpga_irq[] is unsigned so the test does not work.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Found using coccinelle: http://coccinelle.lip6.fr/
> 
Applied, thanks.
