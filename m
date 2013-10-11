From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Oct 2013 01:04:16 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: Fix pin control device address in DT
Message-Id: <20131011010414.GA17597@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1380821741-7515-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1380821741-7515-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 03, 2013 at 05:29:54PM -0700, Kuninori Morimoto wrote:
> 
> Hi Laurent
> 
> > The PFC device is erroneously declared at address 0xfffc000 instead of
> > 0xfffc0000. Fix it.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> 
> This patch solved my issue, thank you
> 
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Sorry for the delay.
I have now queued this up.
