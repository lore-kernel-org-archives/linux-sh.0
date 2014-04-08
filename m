From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Apr 2014 00:29:12 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: Add EHCI MSTP clock
Message-Id: <20140408002911.GC30496@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140407060421.25826.64819.sendpatchset@w520>
 <5342890C.8090703@cogentembedded.com>
In-Reply-To: <5342890C.8090703@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 07, 2014 at 03:16:28PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 07-04-2014 10:04, Magnus Damm wrote:
> 
> >From: Magnus Damm <damm@opensource.se>
> 
> >Add support for EHCI clock gating via the MSTP703 bit on r8a7791.
> 
> >Signed-off-by: Magnus Damm <damm@opensource.se>
> 
>    I have already posted such patch at end of the last week.

Thanks for giving me the luxury of having two patches to choose from:
much better than none. I regret that there could only be one winner :^)

Ordinarily I would take the first one, Sergei's. But I have
decided to take Magnus's as it is simpler due to not cleaning
up the code at the same time as adding the feature described on the wrapper.

