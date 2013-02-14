From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Feb 2013 23:22:55 +0000
Subject: Re: [PATCH] gpio: em: Use irq_domain_add_simple() to fix runtime error
Message-Id: <20130214232252.GA30667@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130212155613.13396.44355.sendpatchset@w520>
In-Reply-To: <20130212155613.13396.44355.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2013 at 05:45:46PM +0100, Linus Walleij wrote:
> On Thu, Feb 14, 2013 at 1:30 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > [Simon]
> >> This appears to be a regression between v3.7 and v3.8-rc1 which
> >> (possibly amongst other things) prevents the NIC on the KZM9D
> >> from functioning.
> >
> > Thanks, Simon. I forgot to add you on the Reported-by. Good to see
> > that you've tested the patch.
> >
> > So how can we merge this one? From my point of view, if v3.8 is
> > difficult timing wise then v3.9 is fine.
> 
> I've applied it to for-next with an Cc: stable tag.

Thanks.
