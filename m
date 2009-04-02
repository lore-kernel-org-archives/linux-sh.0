From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 02 Apr 2009 09:16:47 +0000
Subject: Re: [PATCH v3] dmaengine: sh: Add Support SuperH DMA Engine driver
Message-Id: <49D4827F.6080906@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49C9D558.7030002@renesas.com>
In-Reply-To: <49C9D558.7030002@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Dan.

Thank you for your commnets.

Dan Williams wrote:
> Paul Mundt wrote:
>> On Wed, Mar 25, 2009 at 03:55:20PM +0900, Nobuhiro Iwamatsu wrote:
>>> This supported all DMA channels, and it was tested in SH7722,
>>> SH7780 and SH7763.
>>> This can not use with SH DMA API.
>>>
>>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
>>> Reviewed-by: Matt Fleming <matt@console-pimps.org>
>>
>> I don't know why you dropped Dan from the CC, but you need his Acked-by
>> or Reviewed-by before this can be merged.
> 
> Thanks Paul.
> 
> This version still has the problem of up leveling the descriptor lock to 
>  spin_lock_irqsave from spin_lock_bh.  This poses a problem for 
> completion callback support where callbacks assume that interrupts are 
> enabled, like a timer callback.  I have also spotted a new problem below:
> 

I understood. I fix your undication part.

Best regards,
  Nobuhiro
