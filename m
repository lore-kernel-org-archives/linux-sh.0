From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 03 Nov 2015 14:47:30 +0000
Subject: Re: [PATCH 1/2] watchdog: include: fix some typos
Message-Id: <5638C902.7040509@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1446537616-3452-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1446537616-3452-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-sh@vger.kernel.org

On 11/03/2015 12:00 AM, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   include/linux/watchdog.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index d74a0e907b9e76..fbd752de3a24d5 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -25,7 +25,7 @@ struct watchdog_device;
>    * @ping:	The routine that sends a keepalive ping to the watchdog device.
>    * @status:	The routine that shows the status of the watchdog device.
>    * @set_timeout:The routine for setting the watchdog devices timeout value.
> - * @get_timeleft:The routine that get's the time that's left before a reset.
> + * @get_timeleft:The routine that gets the time left before a reset.
>    * @ref:	The ref operation for dyn. allocated watchdog_device structs
>    * @unref:	The unref operation for dyn. allocated watchdog_device structs
>    * @ioctl:	The routines that handles extra ioctl calls.
> @@ -33,7 +33,7 @@ struct watchdog_device;
>    * The watchdog_ops structure contains a list of low-level operations
>    * that control a watchdog device. It also contains the module that owns
>    * these operations. The start and stop function are mandatory, all other
> - * functions are optonal.
> + * functions are optional.
>    */
>   struct watchdog_ops {
>   	struct module *owner;
>

