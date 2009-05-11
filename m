From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 10:34:11 +0000
Subject: Re: [PATCH] sh: multiple vectors per irq - sh7760
Message-Id: <aec7e5c30905110334j3f98f72auf294f132ba26fb66@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B0AF53.9090007@renesas.com>
In-Reply-To: <49B0AF53.9090007@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 11, 2009 at 7:32 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> So with this patch all DMA channels must use a single linux interrupt.
> Requesting interrupt 34 should be ok in this case (the first DMAC
> vector with value 0x640) but all other interrupt sources are disabled.

Err, the other interrupt sources are not disabled. But they are muxed
into linux interrupt 34 in this case. So the DMA driver needs to be
aware of this and request one interrupt instead of one per channel.

/ magnus
