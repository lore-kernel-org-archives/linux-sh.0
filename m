From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 18 Jul 2008 22:43:23 +0000
Subject: Re: [PATCH] input: Clean up maple keyboard driver
Message-Id: <20080718224323.GA19263@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1213559019.22707.12.camel@localhost.localdomain>
In-Reply-To: <1213559019.22707.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Sun, Jun 15, 2008 at 08:43:39PM +0100, Adrian McMenamin wrote:
> Have a single probe function instead of a probe and a connect function.
> Also tidy a comment.
> 1 files changed, 33 insertions(+), 48 deletions(-)
> 
> 
> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

Ok, so I was going to take this through my tree, but it doesn't apply any
more. Please send an updated version that can be merged.
