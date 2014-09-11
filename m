From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 11 Sep 2014 00:18:48 +0000
Subject: Re: [PATCH 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <5410EA68.3080705@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <54102904.6060703@renesas.com>
In-Reply-To: <54102904.6060703@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

(2014/09/10 22:49), Felipe Balbi wrote:
> On Wed, Sep 10, 2014 at 07:33:40PM +0900, Yoshihiro Shimoda wrote:
>> This patch fixes an issue that the NULL pointer dereference happens
>> when we use g_audio driver. Since the g_audio driver will call
>> usb_ep_disable() in afunc_set_alt() before it calls usb_ep_enable(),
>> the uep->pipe of renesas usbhs driver will be NULL. So, this patch
>> adds a condition to avoid the oops.
>>
>> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Which commit does this fix ? Do we need a Cc: stable ?
> 

I think we need a Cc: stable in this patch because the previous code causes the oops.

Best regards,
Yoshihiro Shimoda
