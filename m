From: Simon Horman <horms@verge.net.au>
Date: Wed, 18 Sep 2013 00:44:37 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: r8a7790 CA7 boot mode support
Message-Id: <20130918004436.GB4330@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130914152848.12327.55620.sendpatchset@w520>
In-Reply-To: <20130914152848.12327.55620.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Sep 15, 2013 at 12:28:48AM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7790 CA7 boot mode support
> 
> [PATCH 01/03] ARM: shmobile: Add r8a7790 CA7 CPU cores to DTSI
> [PATCH 02/03] ARM: shmobile: Extend APMU code to allow single cluster only
> [PATCH 03/03] ARM: shmobile: Include CA7 cores in APMU table
> 
> This series enables the CA7 boot mode on r8a7790. Earlier this was
> included in the r8a7790 SMP patch, but it was removed from the shared
> APMU SMP code during adjustment to r8a7791 single cluster support.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks Magnus,

I have queued these up for v3.13.
