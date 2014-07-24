From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 24 Jul 2014 00:12:01 +0000
Subject: Re: [PATCH/RFC 0/5] R-Car Gen2 DMAC hardware descriptor list support
Message-Id: <1425454.6zkMb8kvSg@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wednesday 23 July 2014 16:56:56 Kuninori Morimoto wrote:

[snip]

> > > 2. cyclic transfer doesn't work
> > > 
> > >    I got attached error.
> > 
> > I'm not too surprised as I haven't tested cyclic DMA yet :-) I'll fix it.
> 
> Hehehe :)
> 
> Please let me know if you need my help

As explained in another e-mail I've run into issues with sleep operations in 
atomic context, and I believe we first need to clarify the DMA engine API 
requirements in term of contexts. Your opinion would be appreciated.

-- 
Regards,

Laurent Pinchart

