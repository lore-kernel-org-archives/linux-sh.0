From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Jul 2013 02:36:09 +0000
Subject: Re: [PATCH 5/6 v2] ARM: shmobile: r8a7778: cleanup registration of hspi
Message-Id: <20130730023609.GG31526@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjt9bwp7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjt9bwp7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 26, 2013 at 05:18:59PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 26-07-2013 11:35, Kuninori Morimoto wrote:
> 
> >sh-hspi driver which doesn't need platform data at the time of
> >registration can be registerd on SoC.
> 
>    I repeat my question about the pinmux settings.

I am holding off until I understand the answer to that question
in relation to "ARM: shmobile: r8a7778: cleanup registration of i2c".

> 
> >And, registering these drivers in the SoC code can avoid
> >unwanted device numbering issue.
> >(ex. the hspi2 device number will be spi.0 if hspi2 only registered)
> 
>    This IMHO is a non-issue.
> 
> >This patch registers it on SoC code as cleanup C code
> 
>    Why not call the patch ARM: shmobile: r8a7778: register HSPI in
> SoC code" then?
