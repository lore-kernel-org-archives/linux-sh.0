From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 27 Apr 2009 08:03:55 +0000
Subject: Re: [PATCH] maple: input: fix up maple mouse driver - v2
Message-Id: <20090427080354.GA26020@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1240685216.4808.13.camel@localhost.localdomain> <1240692198.4808.21.camel@localhost.localdomain>
In-Reply-To: <1240692198.4808.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Sat, Apr 25, 2009 at 09:43:18PM +0100, Adrian McMenamin wrote:
> On Sat, 2009-04-25 at 19:46 +0100, Adrian McMenamin wrote:
> > The maple mouse driver currently in mainline is broken:
> 
> Here is a better fix for this, keeping an open and close, so reducing
> the load on the system when the mouse is not in use, and also properly
> referencing the maple device buffer following the recent update.
> 
> drivers/input/mouse/maplemouse.c |   44
> +++++++++++++++++++------------------
>  1 files changed, 23 insertions(+), 21 deletions(-)
> 
> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

Applied, thanks.
