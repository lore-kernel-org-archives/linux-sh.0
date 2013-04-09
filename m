From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 09 Apr 2013 13:08:46 +0000
Subject: Re: [PATCH 2/2] sh_eth: add R-Car support for real
Message-Id: <516412DE.8020007@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201303290051.32106.sergei.shtylyov@cogentembedded.com> <20130408023936.GA1643@verge.net.au> <20130408090451.GC8917@verge.net.au> <5162C9EA.6060005@cogentembedded.com> <OF927F8D41.407FE3E6-ON80257B47.004FDFDA-80257B47.005090A7@eu.necel.com>
In-Reply-To: <OF927F8D41.407FE3E6-ON80257B47.004FDFDA-80257B47.005090A7@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: phil.edworthy@renesas.com
Cc: Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org, netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com

Hello.

On 08-04-2013 18:40, phil.edworthy@renesas.com wrote:

> Thanks for the patch. When I added r8a7779 support, I had a rather poor
> manual with a lot of information missing. I submitted the patch once I got
> the driver working on a Marzen board, with an REE Expansion Board.

    That must be 3rd type of the expansion board even. I have documentation on 
some Y-R-CAR-H1-BOARD-EXP board, and I have the R0P7779A00020S board mounted 
below Marzen. They seem very different as the latter don't have any switches 
on it.

> One of the main changes you have made is adjusting the offset of the
> control registers. When I did this work originally, I just assumed that
> the base address start at 0x1DE00200, i.e. it included the 0x200 offset.
> This made sense as the registers are then identically positioned to sh4a.

    Yes, but not all SH4 registers exist on R-Car and the Ether base is 
0xFDE00000 according to the datasheet.

> Regards
> Phil

WBR, Sergei

