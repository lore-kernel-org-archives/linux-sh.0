From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Feb 2008 00:55:26 +0000
Subject: Re: [PATCH] Fix 8139too for Dreamcast
Message-Id: <20080204005526.GA21788@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1202081690.9936.11.camel@localhost.localdomain>
In-Reply-To: <1202081690.9936.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Feb 03, 2008 at 11:34:50PM +0000, Adrian McMenamin wrote:
> From: Adrian McMenamin
> 
You only need this if you're submitting a patch from someone else, and
then you still need the email address, or git-am has no idea what to do.

> This fixes the 8139too driver for the Dreamcast to work with the recent coherency patches. All Magnus's work, I just tested it.
> 
> Suggested-by: Magnus Damm

Mail address missing again.

> Submitted-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> 
Do not arbitrarily invent new sign-off tags, read
Documentation/SubmittingPatches.

This patch should also be sent to Jeff Garzik if you actually want it
applied. It also helps to point out the commit-id that broke so it's
clear that this is fixing a regression.
