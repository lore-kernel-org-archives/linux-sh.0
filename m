From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 21 Jun 2010 03:58:10 +0000
Subject: Re: [PATCH 2/2] arch/sh/mm: Eliminate a double lock
Message-Id: <20100621035809.GB29997@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1006201324360.4366@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1006201324360.4366@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, Jun 20, 2010 at 01:24:54PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> The function begins and ends with a read_lock.  The latter is changed to a
> read_unlock.
> 
Indeed, good catch. Applied, thanks.
