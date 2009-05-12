From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Tue, 12 May 2009 03:02:32 +0000
Subject: Re: [PATCH v5] dmaengine: sh: Add Support SuperH DMA Engine driver
Message-Id: <4A08E6C8.8050802@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49E41BA8.4090807@renesas.com>
In-Reply-To: <49E41BA8.4090807@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Dan.

Thank you for your check.

Dan Williams wrote:
> Nobuhiro Iwamatsu wrote:
>> This supported all DMA channels, and it was tested in SH7722,
>> SH7780 and SH7763.
>> This can not use with SH DMA API.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
>> Reviewed-by: Matt Fleming <matt@console-pimps.org>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Acked-by: Maciej Sosnowski <maciej.sosnowski@intel.com>
>> ---
>>  v5: Fix some bug.
>>      Add Cyclic extention API (got hint from dw_dmac.c)
> 
> Have you run this with CONFIG_PROVE_LOCKING=y?  I suspect it will find 
> some issues.  It looks like desc_lock in the interrupt handler is only 
> protecting updates to the CHCR register.  In other places desc_lock is 
> protecting descriptor chain updates.  And the code varies from spin_lock 
> to spin_lock_bh?  If you can't move all register manipulations to bh or 
> process context then you will most likely need a separate register_lock 
> which can be taken with spin_lock_irq... see what CONFIG_PROVE_LOCKING 
> reports.

OK, I check this point, and send report.
> 
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 3b3c01b..0a27f3c 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -81,6 +81,14 @@ config MX3_IPU_IRQS
>>           To avoid bloating the irq_desc[] array we allocate a sufficient
>>           number of IRQ slots and map them dynamically to specific 
>> sources.
>>
>> +config SH_DMAE
>> +       tristate "Renesas SuperH DMAC support"
>> +       depends on SUPERH && SH_DMA
>> +       depends on !SH_DMA_API
>> +       select DMA_ENGINE
>> +       help
>> +         Enable support for the Renesas SuperH DMA controllers.
>> +
>>  config DMA_ENGINE
>>         bool
>>
> 
> This will collide with the TXX9_DMAC config option now sitting in Ralf's 
> tree.  Please put this entry somewhere before MX3_IPU.

OK, I fix this next patch.


Best regards,
 Nobuhiro
