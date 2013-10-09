From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Oct 2013 02:32:31 +0000
Subject: Re: [PATCH 07/08] ARM: shmobile: Add Koelsch LED6, LED7 and LED8 support
Message-Id: <20131009023230.GJ15065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131008033851.20455.68845.sendpatchset@w520>
 <20131008033959.20455.18632.sendpatchset@w520>
 <20131009021324.GH15065@verge.net.au>
In-Reply-To: <20131009021324.GH15065@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 09, 2013 at 11:13:26AM +0900, Simon Horman wrote:
> On Tue, Oct 08, 2013 at 12:39:59PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Enable Koelsch LEDs for GPIO output testing purpose.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Hi Magnus,
> 
> this patch does not seem to apply on top of renesas-devel-20131004.
> Could you please rebase it and the following on top of
> renesas-devel-20131004 or the latest devel tag?

Scratch that, I see that my problem was that I was missing the previous
patch.

I have now queued up this patch.
