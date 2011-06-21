From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Jun 2011 16:27:36 +0000
Subject: Re: [PATCH 5/5] ARM: mach-shmobile: ag5evm: SDHI requires waiting for idle
Message-Id: <20110621162735.GL7920@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au> <1308610812-3479-6-git-send-email-horms@verge.net.au> <m2aadbtbbl.fsf@bob.laptop.org>
In-Reply-To: <m2aadbtbbl.fsf@bob.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Ball <cjb@laptop.org>
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Tue, Jun 21, 2011 at 12:10:22PM -0400, Chris Ball wrote:
> On Mon, Jun 20 2011, Simon Horman wrote:
> > Dependencies:
> > 	"mmc: sdhi: Add write16_hook"
> > 	"ARM: mach-shmobile: ag5evm: consistently name sdhi info structures"
> 
> Could I get your ACK for this one, so that I can merge patches 1/2/3/5
> together via the MMC tree?
> 
Well, this has a dependency on 4/5 which I've already applied. I was
simply going to wait for 1-3 to be merged via your tree and then roll in
this last one on top of that. If you want to take them all that's ok too,
git should be able to deal with any merge conflicts fine.
