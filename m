From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 30 Jul 2013 20:41:10 +0000
Subject: Re: [PATCH] sh_eth: r8a7790: Handle the RFE (Receive FIFO overflow Error) interrupt
Message-Id: <51F824E6.9080006@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375142928-17769-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375142928-17769-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>

Hello.

On 07/30/2013 04:08 AM, Laurent Pinchart wrote:

> The RFE interrupt is enabled for the r8a7790 but isn't handled,
> resulting in the interrupts core noticing unhandled interrupts, and
> eventually disabling the ethernet IRQ.
>
> Fix it by adding RFE to the bitmask of error interrupts to be handled
> for r8a7790.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---

    Laurent forgot to specify that the patch is for the net-next.git.

WBR, Sergei

