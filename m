From: Simon Horman <horms@verge.net.au>
Date: Sat, 14 Nov 2015 00:16:27 +0000
Subject: Re: [PATCH net] ravb: Fix int mask value overwritten issue
Message-Id: <20151114001627.GB25806@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447410289-3741-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdXLtR84Cormbh6HbB7fE6mMh9e-0EX5kavmSGHJKLZRAA@mail.gmail.com>
In-Reply-To: <CAMuHMdXLtR84Cormbh6HbB7fE6mMh9e-0EX5kavmSGHJKLZRAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

On Fri, Nov 13, 2015 at 11:45:28AM +0100, Geert Uytterhoeven wrote:
> Hi Kaneko-san,
> 
> On Fri, Nov 13, 2015 at 11:24 AM, Yoshihiro Kaneko
> <ykaneko0929@gmail.com> wrote:
> > From: Masaru Nagai <masaru.nagai.vx@renesas.com>
> >
> > When RX/TX interrupt for Network Control queue and Best Effort queue
> > is issued at the same time, the interrupt mask of Network Control
> > queue will be reset when the mask of Best Effort queue is set.
> 
> Nice catch!
> 
> At first I was a bit puzzled why this would make a difference, but
> the key is "will be reset in the next iteration of the for loop", which
> falls outside of the visible context.
> 
> > This patch fixes this problem.
> >
> > Signed-off-by: Masaru Nagai <masaru.nagai.vx@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
