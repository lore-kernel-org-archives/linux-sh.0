From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 02 Mar 2010 03:13:47 +0000
Subject: Re: [PATCH] SH: No need to explicitly include <linux/rwlock.h>.
Message-Id: <20100302031347.GE20256@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Feb 27, 2010 at 01:35:08PM -0500, Robert P. J. Day wrote:
> 
> Since <linux/spinlock.h> already includes <linux/rwlock.h>, and the
> latter file will warn about not having included the former file
> anyway, there is no value in including rwlock.h explicitly.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
Applied.
