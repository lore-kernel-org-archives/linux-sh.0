From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Jan 2015 13:52:15 +0000
Subject: Re: [PATCH] i2c: slave-eeprom: fix boundary check when using sysfs
Message-Id: <2988844.NmFWX0K5r9@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1421684575-6679-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1421684575-6679-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Monday 19 January 2015 17:22:55 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Due to a copy&paste error, the last byte of the shared memory was not
> accessible via sysfs.
> 
> Reported-by: Debora Grosse <debora@mds.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/i2c/i2c-slave-eeprom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
> index f432f81b0414..8f417e9054ac 100644
> --- a/drivers/i2c/i2c-slave-eeprom.c
> +++ b/drivers/i2c/i2c-slave-eeprom.c
> @@ -74,7 +74,7 @@ static ssize_t i2c_slave_eeprom_bin_read(struct file
> *filp, struct kobject *kobj struct eeprom_data *eeprom;
>  	unsigned long flags;
> 
> -	if (off + count >= attr->size)
> +	if (off + count > attr->size)
>  		return -EFBIG;
> 
>  	eeprom = dev_get_drvdata(container_of(kobj, struct device, kobj));
> @@ -92,7 +92,7 @@ static ssize_t i2c_slave_eeprom_bin_write(struct file
> *filp, struct kobject *kob struct eeprom_data *eeprom;
>  	unsigned long flags;
> 
> -	if (off + count >= attr->size)
> +	if (off + count > attr->size)
>  		return -EFBIG;
> 
>  	eeprom = dev_get_drvdata(container_of(kobj, struct device, kobj));

-- 
Regards,

Laurent Pinchart

