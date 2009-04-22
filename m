From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 22 Apr 2009 11:11:46 +0000
Subject: Re: [PATCH] sh: sh7785lcr: fix defconfig for 29-bit mode
Message-Id: <49EEFB72.8000002@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49EEF66B.2010507@renesas.com>
In-Reply-To: <49EEF66B.2010507@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dear Michael,

Michael Trimarchi wrote:
> Yoshihiro Shimoda wrote:
>> Fix the problem that cannot work 29-bit mode when use sh7785lcr_defconfig.
>>
>> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
>>   
> Just to know... Is it impossible to select the 29bit mode for sh7785?

This patch is changed from CONFIG_32BIT=y to CONFIG_29BIT=y in sh7785lcr_defconfig.
If kernel config set CONFIG_32BIT, sh7785 cannot work 29-bit mode.

Best regards,
Yoshihiro Shimoda

