From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Sat, 19 Jul 2008 07:04:09 +0000
Subject: Re: [PATCH] sh7760mmc: host driver for SH7760 MMC interface
Message-Id: <488191E9.6020904@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080717110119.GA14949@roarinelk.homelinux.net>
In-Reply-To: <20080717110119.GA14949@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Pierre Ossman wrote:
> On Thu, 17 Jul 2008 13:03:53 +0200
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
>> From: Manuel Lauss <mano@roarinelk.homelinux.net>
>>
>> Host driver for SH7760 on-chip MMCIF interface.
>>
>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>> ---
> 
> Just some minor things:
> 
>> +static void shmmc_cmd(struct shmmc_host *host, struct mmc_command *cmd)
>> +{
>> +	unsigned char cmdtyr, rsptyr, i;
>> +
>> +	shmmc_clock(host, 0);
>> +	host->cmd = cmd;
>> +
>> +	/* enable MMCIF and "cmd xfer timeout" irqs */
>> +	host->ien1 |= INTCR1_IRQEN | INTCR1_CTERIE;
>> +
>> +	/* setup command type */
>> +	cmdtyr = 0;
>> +	if (cmd->opcode = 12)
>> +		cmdtyr = CMDTYR_CMD12;
>> +
> 
> Seems more likely that this flag should be set on any stop command.

There are other stop commands?
Anyway, changed to a check for the "mrq->stop" command.


>> +
>> +	blksz_bits = ffs(data->blksz) - 1;
>> +	BUG_ON((1 << blksz_bits) != data->blksz);
> 
> This is not a bug. You should fail the request with -EINVAL if you
> cannot handle it.

Actually this is just a test of ffs() on SH ;-)
Gone now.


>> +static int __devexit shmmc_remove(struct platform_device *dev)
>> +{
>> +	struct mmc_host *mmc = platform_get_drvdata(dev);
>> +	struct shmmc_host *host = mmc_priv(mmc);
>> +	struct resource *r;
>> +
>> +	MMC_OUTB(host, INTCR0, 0);
>> +	MMC_OUTB(host, INTCR1, 0);
>> +	MMC_OUTB(host, INTCR2, 0);
>> +	shmmc_clrirq(host);
>> +	tasklet_disable(&host->done_task);
>> +	mmc_remove_host(mmc);
> 
> Don't free up any resources needed to handle requests before
> mmc_remove_host() has returned.

Okay, done.


> Also, remember to run the mmc_test test suite on the driver. It tends
> to find a lot of problems.

Will do.

I'll resend a new and tested patch after the weekend.

Thanks Pierre!
	Manuel Lauss

