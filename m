From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Dec 2014 05:34:27 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: Use R8A7779_CLK_P as SCIF parent clock
Message-Id: <20141216053427.GB12455@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141215050034.357.93456.sendpatchset@w520>
In-Reply-To: <20141215050034.357.93456.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 15, 2014 at 03:00:53PM +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 15, 2014 at 6:00 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> >
> > Use R8A7779_CLK_P as parent clock for SCIF devices on r8a7779.
> > With this change in place the SCIF CCF handling matches the
> > legacy clock code. Also, this matches the data sheet.
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
