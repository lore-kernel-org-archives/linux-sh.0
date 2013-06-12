From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:09:47 +0000
Subject: Re: [PATCH 03/06] ARM: shmobile: r8a7779 SMP with SCU boot fn and args
Message-Id: <20130612140946.GT32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130610091925.18944.68117.sendpatchset@w520>
 <20130610091956.18944.57224.sendpatchset@w520>
In-Reply-To: <20130610091956.18944.57224.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 10, 2013 at 06:19:56PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Let r8a7779 make use of shmobile_boot_fn and shmobile_boot_arg
> together with shmobile_boot_scu and the SCU base address.

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
