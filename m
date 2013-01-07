From: Simon Horman <horms@verge.net.au>
Date: Mon, 07 Jan 2013 02:22:26 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: Use of_machine_is_compatible()
Message-Id: <20130107022226.GL2935@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357236857-12106-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357236857-12106-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 03, 2013 at 07:14:17PM +0100, Laurent Pinchart wrote:
> The machine number is hardcoded to ~0 on DT-enabled machines, making
> machine_is_*() always fail when support for more than one machine is
> compiled into the kernel. Replace the machine_is_kzm9g() call with
> of_machine_is_compatible("renesas,kzm9g").
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have applied this to the boards branch.
