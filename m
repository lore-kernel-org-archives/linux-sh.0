From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 03 Aug 2009 11:41:14 +0000
Subject: Re: [PATCH] usb: move r8a66597 register defines
Message-Id: <4A76CCDA.3090103@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Move r8a66597 hardware register definitions from the host
> controller header file to the platform data header file.
> 
> With this change in place we can easily share register
> definitions between the host controller driver and a future
> gadget driver.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---

Thank you for your patch.
I tested this patch and it was working.

Acked-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Thanks,
Yoshihiro Shimoda
