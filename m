From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Date: Mon, 13 Apr 2015 22:13:48 +0000
Subject: Re: [PATCH resend] Renesas Ethernet AVB driver
Message-Id: <552C3F9C.5070200@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <2926619.fiYHPz1IBk@wasted.cogentembedded.com> <1427982999.18722.35.camel@xylophone.i.decadent.org.uk> <552C2849.2080503@cogentembedded.com>
In-Reply-To: <552C2849.2080503@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

On 13.04.2015 22:34, Sergei Shtylyov wrote:
> Hello.
> 
> On 04/02/2015 04:56 PM, Ben Hutchings wrote:
> 
>> This driver looks somewhat similar to sh-eth, but lacks some of the
>> recent bug fixes made to that.  At least commit 283e38db65e7 ("sh_eth:
>> Fix serialisation of interrupt disable with interrupt & NAPI handler")
>> appears to be applicable, but there are probably others.
> 
>     I suspect this issue applies to many drivers...
>     I couldn't reproduce the bug that patch was fixing, so left this fix out 
> for the time being. Others cases were fixed (if applicable).

Maybe its just harder to trigger but it indeed looks similar to what Ben
has fixed for sh-eth. I wonder if that shutdown flag in the fix is
really needed though. IMHO it should be save if we simply call
napi_disable first, then disable irqs on hardware and finally
synchronize_irq...

Lino



