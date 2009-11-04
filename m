From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 04 Nov 2009 03:15:40 +0000
Subject: Re: [PATCH] sh: Make sure indexes are positive
Message-Id: <20091104031540.GF12841@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4AEF0572.9020609@gmail.com>
In-Reply-To: <4AEF0572.9020609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 02, 2009 at 05:14:42PM +0100, Roel Kluin wrote:
> The indexes are signed, make sure they are not negative
> when we read array elements.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

In practice none of these are likely to be an issue, but it doesn't
really hurt to add the sanity checks given that there's already a number
of them anyways. So, applied.
