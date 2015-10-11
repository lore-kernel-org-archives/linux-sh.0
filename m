From: Simon Horman <horms@verge.net.au>
Date: Sun, 11 Oct 2015 23:54:23 +0000
Subject: Re: [PATCH] ARM: shmobile: porter: add I2C2 DT support
Message-Id: <20151011235420.GA20025@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <84974694.25bFZffQKN@wasted.cogentembedded.com>
 <20151009011336.GB14231@verge.net.au>
 <5617FF0E.1000300@cogentembedded.com>
In-Reply-To: <5617FF0E.1000300@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 09, 2015 at 08:53:18PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 10/09/2015 04:13 AM, Simon Horman wrote:
> 
> >>Define the Porter board dependent part of the I2C2 device node.
> >>
> >>This patch is  analogous to the commit 29a647c396a0 ("ARM: shmobile:
> >>henninger: add I2C2 DT support") as there are no differences between
> >>the boards in this respect.
> >>
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >Thanks Sergei,
> 
> >I have queued this up for v4.4.
> 
>    Not seeing anything from renesas.git running 'git fetch'. Forgot to push? :-)

Yes, sorry about that.
I've pushed it now.
