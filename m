From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 05 Sep 2009 19:29:07 +0000
Subject: Re: [PATCH v6] dmaengine: sh: Add Support SuperH DMA Engine driver
Message-Id: <4AA2BC03.8030205@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4AA0CD9E.3030908@renesas.com>
In-Reply-To: <4AA0CD9E.3030908@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Nobuhiro Iwamatsu wrote:
> Hi, Dan.
> 
> Nobuhiro Iwamatsu wrote:
>> Hi, Dan.
>>
>> Thank you for your check.
>>
>> Dan Williams wrote:
>>> Nobuhiro Iwamatsu wrote:
>>>> This supported all DMA channels, and it was tested in SH7722,
>>>> SH7780 and SH7763.
>>>> This can not use with SH DMA API.
>>>>
>>>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
>>>> Reviewed-by: Matt Fleming <matt@console-pimps.org>
>>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>>> Acked-by: Maciej Sosnowski <maciej.sosnowski@intel.com>
>>>> ---
>>>>  v5: Fix some bug.
>>>>      Add Cyclic extention API (got hint from dw_dmac.c)
>>> Have you run this with CONFIG_PROVE_LOCKING=y?  I suspect it will find
>>> some issues.  It looks like desc_lock in the interrupt handler is only
>>> protecting updates to the CHCR register.  In other places desc_lock is
>>> protecting descriptor chain updates.  And the code varies from spin_lock
>>> to spin_lock_bh?  If you can't move all register manipulations to bh or
>>> process context then you will most likely need a separate register_lock
>>> which can be taken with spin_lock_irq... see what CONFIG_PROVE_LOCKING
>>> reports.
>> OK, I check this point, and send report.
> I checked this.
> Work fine.
> 
> I send update patch.
> 

Yes, the locking looks better in this version.  Can you respin this
patch against async_tx.git/next [1]?  The 'tx_list' field of struct
dma_async_tx_descriptor is set to be removed in 2.6.32, so you need to
define it locally in struct sh_desc.  Once that is done and you get an
ack from Paul I will add this to the queue for 2.6.32.

Thanks,
Dan

[1]:
git://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx.git next
