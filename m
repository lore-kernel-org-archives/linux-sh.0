From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Sep 2010 08:30:23 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Extend AP4EVB LCD comments
Message-Id: <20100914083023.GJ7336@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 31, 2010 at 06:22:36PM +0900, Magnus Damm wrote:
> Extend dip switch comments for QHD and WVGA LCD panels
> on AP4EVB. Similar to the Ecovec comments.

On Tue, Aug 31, 2010 at 06:27:53PM +0900, Magnus Damm wrote:
> Use evt2irq() for DMAC resources on sh7372.
> 
> This makes the code easier to read and also
> allows adjusting the INTC base offset without
> breaking platform data.

Applied, thanks.
