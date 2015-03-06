From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 06 Mar 2015 06:54:48 +0000
Subject: Re: [PATCH] usb: renesas_usbhs: Add access control for INTSTS1 and INTENB1 register
Message-Id: <54F94F38.4020304@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420763321-4868-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1420763321-4868-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ping?

(2015/01/16 19:10), yoshihiro shimoda wrote:
> Hi Iwamatsu-san,
>
>> INTSTS1 and INTENB1 register of renesas_usbhs can access only Host mode.
>> This adds process of accessing INTSTS1 and INTENB1 only when renesas_usbhs
>> is Host mode.
>>
>> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.yj@renesas.com>
>
> Thank you for the patch.
>
> Acked-by: Yoshihiro Shimoda<yoshihiro.shimoda.uh@renesas.com>
>
> Best regards,
> Yoshihiro Shimoda
>

