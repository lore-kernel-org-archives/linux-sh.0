From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Jun 2013 02:28:56 +0000
Subject: Re: [PATCH 1/3 v3] ARM: shmobile: r8a7778: add I2C support
Message-Id: <20130604022856.GT23054@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 02, 2013 at 09:16:27PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 05/28/2013 08:22 AM, Kuninori Morimoto wrote:
> 
> >Add a platform device for the r8a7778 I2C.
> 
>    You're also adding several clocks and not mentioning it.
> Please just copy the description from our I2C patch (to be dumped now),

It seems that the arm-soc people would like a separate clocks branch.
So would it be possible to split the patch into a clocks and a non-clocks
patch, each with an appropriate changelog?

> 
> >Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> >Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> WBR, Sergei
> 
