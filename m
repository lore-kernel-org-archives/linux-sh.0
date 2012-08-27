From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Aug 2012 08:24:50 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: marzen: defconfig update
Message-Id: <20120827082450.GB31129@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1345876664-2590-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1345876664-2590-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Aug 25, 2012 at 03:37:43PM +0900, Simon Horman wrote:
> Update marzen defconfig
> * Enable SDHI and MMC Block device as SDHI hw
>   is now supported.
> * Default to NFS root, this is consistent with many other
>   shmobile boards
> * Enable UNIX and INOTIFY_USER which is required by udevd
> 
> Other changes are noise due to using make savedefconfig
> to create the new defconfig.

This patch was based on an old version of Phil Edworthy's
"Add SDHI to Marzen board" series. I will post v2 of this patch
which is based on v2 of that patch series.
