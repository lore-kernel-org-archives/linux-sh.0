From: Simon Horman <horms@verge.net.au>
Date: Tue, 25 Aug 2015 22:55:39 +0000
Subject: Re: [PATCH repost net-next] net: compile renesas directory if NET_VENDOR_RENESAS is configured
Message-Id: <20150825225539.GA30202@vergenet.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20150825080320.GA15681@vergenet.net>
 <55DC2899.2050205@cogentembedded.com>
 <55DCDB0D.8060201@cogentembedded.com>
In-Reply-To: <55DCDB0D.8060201@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Wed, Aug 26, 2015 at 12:15:57AM +0300, Sergei Shtylyov wrote:
> On 08/25/2015 11:34 AM, Sergei Shtylyov wrote:
> 
> >>From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >>
> >>Currently the renesas ethernet driver directory is compiled if SH_ETH is
> >>configured rather than NET_VENDOR_RENESAS. Although incorrect that was
> >>quite harmless as until recently as SH_ETH configured the only driver in
> >>the renesas directory. However, as of c156633f1353 ("Renesas Ethernet AVB
> >>driver proper") the renesas directory includes another driver, configured
> >>by RAVB, and it makes little sense for it to have a hidden dependency on
> >>SH_ETH.
> >>
> >>Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >>[horms: rewrote changelog]
> >>Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> >    Sorry about missing that when submitting the AVB driver.
> 
>    BTW, why against net-next? I consider this a fix.

I wasn't sure which way to go and decided to err on the side of caution with a
net-next submission. I have no objections to it being considered for next.
