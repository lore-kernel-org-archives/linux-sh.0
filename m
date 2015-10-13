From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 Oct 2015 01:01:43 +0000
Subject: Re: [PATCH] ARM: shmobile: porter: enable internal PCI and USB PHY
Message-Id: <20151013010142.GA4836@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <3151312.grtDDBsSl8@wasted.cogentembedded.com>
 <4574604.BmF3DtBjpm@wasted.cogentembedded.com>
In-Reply-To: <4574604.BmF3DtBjpm@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 13, 2015 at 01:12:18AM +0300, Sergei Shtylyov wrote:
> Enable  internal AHB-PCI bridges for the USB EHCI/OHCI controllers attached
> to them and also enable  USB PHY device  for the Porter board.  We have to
> enable  everything in one patch since EHCI/OHCI devices are already linked
> to the USB PHY device.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I have queued this up for v4.4.
