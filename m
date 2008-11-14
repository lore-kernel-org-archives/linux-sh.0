From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Fri, 14 Nov 2008 02:47:45 +0000
Subject: Re: [PATCH] usb: m66592 and r8a66597 resource changes
Message-Id: <491CE6D1.20107@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081113064637.5215.76176.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081113064637.5215.76176.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus-san,

Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Use the more common platform_get_resource() together with index instead
> of depending on the resource name and platform_get_resource_by_name().
> Replace the resource_len() implementation with resource_size().
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Thank you for your patch.
I tested this patch and confirmed it is working.

Thanks,
Yoshihiro Shimoda
