From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 Mar 2011 13:50:32 +0000
Subject: Re: [PATCH 0/6 v2] mmc: split the tmio driver into several modules
Message-Id: <20110323135032.GA25892@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Mar 23, 2011 at 02:42:29PM +0100, Guennadi Liakhovetski wrote:
> This patch-series touches code under
> 
> arch/arm/mach-shmobile
> arch/sh/boards
> drivers/mfd
> drivers/mmc/host
> 
> Perhaps, it would be best to collect necessary acks from Paul and push 
> them all via mmc?
> 
That works fine for me, it would be better to keep these grouped together
due to the ordering and it would take several merges to get everything in
sync otherwise. The bulk of this is drivers/mmc churn, so I'll let Chris
decide how he wants to handle it.

Anyways, for the series:

	Acked-by: Paul Mundt <lethal@linux-sh.org>
