From: Simon Horman <horms@verge.net.au>
Date: Wed, 22 Jan 2014 00:34:56 +0000
Subject: Re: [PATCH 0/3] Renesas serial sh-sci DT fixes
Message-Id: <20140122003455.GA22542@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1390308519-31320-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1390308519-31320-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 21, 2014 at 01:48:36PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> These three patches fix issues with the sh-sci DT support.
> 
> The first patch fixes a typo in the DT bindings documentation example. The two
> other patches fix issues in the r8a7790 serial port DT nodes caused by merging
> work in progress version of DT support instead of the latest available one.
> 
> The first two patches are candidates for v3.14-rc. I'd like to third patch to
> join them if possible.

Forgive me for blase but these changes seem to be more on the
cosmetic side than on the fixing problems side. I'm more inclined to
queue them up for v3.15 than v3.14-rc.

> 
> Simon, could you please pick them up ? The first patch touches DT bindings
> documentation so I've CC'ed the devicetree mailing list, but the fix is so
> trivial that I don't think the DT bindings maintainers' Ack is required.

Agreed.
