From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 20 Jun 2010 13:51:46 +0000
Subject: Re: [PATCH 2/2] arch/sh/mm: Eliminate a double lock
Message-Id: <87lja9q0b1.fsf@linux-g6p1.site>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1006201324360.4366@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1006201324360.4366@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, 20 Jun 2010 13:24:54 +0200 (CEST), Julia Lawall <julia@diku.dk> wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> The function begins and ends with a read_lock.  The latter is changed to a
> read_unlock.

I think we've been quite lucky here so far, in that no one takes a
write_lock after we've double-read-locked pmb_rwlock.

Acked-by: Matt Fleming <matt@console-pimps.org>
